# Quickshell File Manager Tab Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement a native QML file manager tab for the right panel using `Quickshell.Io.Process` to list directories and open files without relying on external daemons.

**Architecture:** A `FileManager.qml` component loads inside `RightPanel.qml`. It maintains a `ListModel` populated by parsing the stdout of an `ls` command via `SplitParser`. Interacting with files launches `xdg-open` via another `Process`.

**Tech Stack:** Quickshell, QtQuick, QML, Linux shell (`ls`, `xdg-open`)

---

### Task 1: Create the basic FileManager UI and Model

**Files:**
- Create: `/home/bis/.config/quickshell/mi-shell/widgets/rightpanel/FileManager.qml`

- [ ] **Step 1: Write the minimal implementation structure**

```qml
import QtQuick
import QtQuick.Controls.Basic
import Quickshell
import Quickshell.Io
import "../../theme"
import "../common"

Item {
    id: root
    
    // Default to home directory
    property string currentPath: "/home/bis" 
    
    ListModel {
        id: fileModel
    }
    
    Column {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10
        
        // Header
        Row {
            width: parent.width
            spacing: 10
            
            ThemeText {
                text: "󰁍" // Back arrow icon
                font.pixelSize: 20
                visible: root.currentPath !== "/"
                
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        // Very naive go up logic for now
                        let parts = root.currentPath.split("/");
                        parts.pop();
                        root.currentPath = parts.join("/") || "/";
                    }
                }
            }
            
            ThemeText {
                text: root.currentPath
                font.bold: true
                elide: Text.ElideLeft
                width: parent.width - 40
            }
        }
        
        // List
        ListView {
            id: fileList
            width: parent.width
            height: parent.height - 40
            model: fileModel
            clip: true
            
            delegate: Item {
                width: ListView.view.width
                height: 30
                
                required property string name
                required property bool isDir
                
                Row {
                    anchors.fill: parent
                    spacing: 10
                    
                    ThemeText {
                        text: isDir ? "󰉋" : "󰈔"
                        color: isDir ? Theme.accent : Theme.textMuted
                    }
                    
                    ThemeText {
                        text: name
                        elide: Text.ElideRight
                        width: parent.width - 30
                    }
                }
            }
        }
    }
}
```

- [ ] **Step 2: Commit**

```bash
git add /home/bis/.config/quickshell/mi-shell/widgets/rightpanel/FileManager.qml
git commit -m "feat: add initial FileManager UI structure"
```

---

### Task 2: Implement Directory Loading via Quickshell Process

**Files:**
- Modify: `/home/bis/.config/quickshell/mi-shell/widgets/rightpanel/FileManager.qml:20-30` (approx, inside root Item)

- [ ] **Step 1: Add the Process and Parser logic to FileManager.qml**

```qml
    // Add this right after the ListModel definition
    
    function loadDirectory() {
        fileModel.clear();
        if (root.currentPath === "") root.currentPath = "/";
        lsProcess.command = ["sh", "-c", "ls -1p --group-directories-first \"" + root.currentPath + "\""];
        lsProcess.running = true;
    }
    
    onCurrentPathChanged: {
        loadDirectory();
    }
    
    Component.onCompleted: {
        loadDirectory();
    }
    
    Process {
        id: lsProcess
        
        stdout: SplitParser {
            splitMarker: "\n"
            onRead: line => {
                if (line === "") return;
                
                let isDirectory = line.endsWith("/");
                let fileName = isDirectory ? line.substring(0, line.length - 1) : line;
                
                fileModel.append({
                    name: fileName,
                    isDir: isDirectory
                });
            }
        }
    }
```

- [ ] **Step 2: Test by running the component directly**

```bash
quickshell -p /home/bis/.config/quickshell/mi-shell/widgets/rightpanel/FileManager.qml
```
*(Verify it opens, lists the home directory files, and shows correct icons)*

- [ ] **Step 3: Commit**

```bash
git add /home/bis/.config/quickshell/mi-shell/widgets/rightpanel/FileManager.qml
git commit -m "feat: populate file list using Quickshell Process and SplitParser"
```

---

### Task 3: Implement Interaction (Navigation and Opening files)

**Files:**
- Modify: `/home/bis/.config/quickshell/mi-shell/widgets/rightpanel/FileManager.qml`

- [ ] **Step 1: Add a process to open files, and a MouseArea to the delegate**

```qml
    // Add this process near lsProcess
    Process {
        id: openProcess
    }
```

```qml
            // Inside the delegate: Item { ...
            delegate: Item {
                width: ListView.view.width
                height: 30
                
                required property string name
                required property bool isDir
                
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    
                    Rectangle {
                        anchors.fill: parent
                        color: parent.containsMouse ? Theme.accentDim : "transparent"
                        radius: 4
                    }
                    
                    onClicked: {
                        if (isDir) {
                            // Ensure no double slashes if at root
                            let sep = root.currentPath === "/" ? "" : "/";
                            root.currentPath = root.currentPath + sep + name;
                        } else {
                            // Open file
                            let sep = root.currentPath === "/" ? "" : "/";
                            let fullPath = root.currentPath + sep + name;
                            openProcess.command = ["xdg-open", fullPath];
                            openProcess.running = true;
                        }
                    }
                }
                
                Row { // ... existing row ...
```

- [ ] **Step 2: Test interaction**

```bash
quickshell -p /home/bis/.config/quickshell/mi-shell/widgets/rightpanel/FileManager.qml
```
*(Verify clicking a folder navigates into it, clicking back navigates up, clicking a file opens it)*

- [ ] **Step 3: Commit**

```bash
git add /home/bis/.config/quickshell/mi-shell/widgets/rightpanel/FileManager.qml
git commit -m "feat: handle directory navigation and file launching"
```

---

### Task 4: Integrate FileManager into RightPanel.qml

**Files:**
- Modify: `/home/bis/.config/quickshell/mi-shell/widgets/rightpanel/RightPanel.qml`

- [ ] **Step 1: Add state for selected tab and conditionally render FileManager**

```qml
    // In RightPanel.qml, inside PanelWindow:
    property int selectedTabIndex: 0 // 0: Links, 1: Files, 2: Chat
```

```qml
        // In the Row containing the PanelTabs, update them:
        Row {
            width: parent.width
            spacing: 15
            leftPadding: 24

            PanelTab {
                tabText: "󰌹 Links"
                tabSelected: root.selectedTabIndex === 0
                onClicked: root.selectedTabIndex = 0
            }
            PanelTab {
                tabText: "󰉋 Files"
                tabSelected: root.selectedTabIndex === 1
                onClicked: root.selectedTabIndex = 1
            }
            PanelTab {
                tabText: "󰭻 Chat"
                tabSelected: root.selectedTabIndex === 2
                onClicked: root.selectedTabIndex = 2
            }
        }
```

```qml
        // Below the PanelTab Row, conditionally load the content:
        
        Loader {
            width: parent.width
            // Calculate remaining height: parent.height - rowHeight - margins
            height: parent.height - 80 
            sourceComponent: root.selectedTabIndex === 0 ? linksComponent : 
                             root.selectedTabIndex === 1 ? filesComponent : null
        }
        
        Component {
            id: linksComponent
            Item {
                // Wrap existing Links UI
                HyprlandFocusGrab {
                    id: grab
                    windows: [root, linkInput.control]
                }

                LinkInputBox {
                    id: linkInput
                    control.focus: root.focus
                    anchors.top: parent.top
                }
            }
        }
        
        Component {
            id: filesComponent
            FileManager {
                anchors.fill: parent
            }
        }
```
*(Note: adjust anchors/heights of the Loader so it fits within the Column without overflowing)*

- [ ] **Step 2: Commit**

```bash
git add /home/bis/.config/quickshell/mi-shell/widgets/rightpanel/RightPanel.qml
git commit -m "feat: wire up tabs in RightPanel to switch to FileManager"
```

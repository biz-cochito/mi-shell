function exportLinks(nameField, exportProcess, textArea) {
    let fileName = nameField.text.trim();
    let fileContent = textArea.text;

    if (fileName === "") {
        let date = new Date();
        let pad = (n) => String(n).padStart(2, "0");
        let timestamp =
            date.getFullYear() +
            "-" +
            pad(date.getMonth() + 1) +
            "-" +
            pad(date.getDate()) +
            "_" +
            pad(date.getHours()) +
            "-" +
            pad(date.getMinutes()) +
            "-" +
            pad(date.getSeconds());
        fileName = "links_" + timestamp;
    }

    if (!fileName.endsWith(".txt")) {
        fileName += ".txt";
    }

    let expectedFileName = fileName;
    let expectedPath =
        Quickshell.env("HOME") +
        "/AppData/Configs/Default/Links/" +
        expectedFileName;

    let FILE_EXISTS;
    try {
        let existingContent = Quickshell.readFile(expectedPath);
        if (existingContent !== null && existingContent !== undefined) {
            fileContent = existingContent + "\n" + fileContent;
            FILE_EXISTS = true;
        } else {
            FILE_EXISTS = false;
        }
    } catch (e) {
        // File does not exist yet or cannot be read, proceed as normal
    }

    if (!FILE_EXISTS) {
        fileContent = `${fileName}\n${textArea.text}`;
    }

    let exportPath =
        Quickshell.env("HOME") + "/AppData/Configs/Default/Links/" + fileName;

    exportProcess.command = [
        "sh",
        "-c",
        'printf \'%s\' "$1" > "$2"',
        "_",
        fileContent,
        exportPath,
    ];
    exportProcess.running = true;

    // Clear the text inputs
    textArea.text = "";
    nameField.text = "";
}

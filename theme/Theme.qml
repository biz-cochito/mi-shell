pragma Singleton
import QtQuick

QtObject {
    id: root

    property string activeTheme: "Midnight"

    // Core Colors
    property color background
    property color surface

    // Text Colors
    property color text
    property color textMuted
    property color textActive
    property color textBright

    // Accents & Interactive
    property color accent
    property color accentDim
    property color active

    // Borders
    property color border
    property color borderFocus

    // Status Colors
    property color error
    property color warning
    property color success
    property color info

    // Globals
    property int borderRadius: 4
    property string fontFamily: "Maple Mono"
    property int fontSize: 16

    property var palettes: ({
        "Midnight": {
            background: "#252526",
            surface: "#353535",
            text: "#c7c7c7",
            textMuted: "#a7a7a7",
            textActive: "#ffffff",
            textBright: "#d7f7d7",
            accent: "#6e94b2",
            accentDim: "#4f6e87",
            active: "#7fa563",
            border: "#4f6e87",
            borderFocus: "#d7b2e8",
            error: "#d8647e",
            warning: "#f3be7c",
            success: "#99b782",
            info: "#6e94b2"
        },
        "Nord": {
            background: "#2E3440",
            surface: "#3B4252",
            text: "#D8DEE9",
            textMuted: "#4C566A",
            textActive: "#ECEFF4",
            textBright: "#E5E9F0",
            accent: "#88C0D0",
            accentDim: "#81A1C1",
            active: "#A3BE8C",
            border: "#434C5E",
            borderFocus: "#5E81AC",
            error: "#BF616A",
            warning: "#EBCB8B",
            success: "#A3BE8C",
            info: "#81A1C1"
        },
        "Dracula": {
            background: "#282a36",
            surface: "#44475a",
            text: "#f8f8f2",
            textMuted: "#6272a4",
            textActive: "#ffffff",
            textBright: "#8be9fd",
            accent: "#bd93f9",
            accentDim: "#ff79c6",
            active: "#50fa7b",
            border: "#6272a4",
            borderFocus: "#ff79c6",
            error: "#ff5555",
            warning: "#f1fa8c",
            success: "#50fa7b",
            info: "#8be9fd"
        },
        "Catppuccin": {
            background: "#1e1e2e",
            surface: "#313244",
            text: "#cdd6f4",
            textMuted: "#6c7086",
            textActive: "#ffffff",
            textBright: "#f5e0dc",
            accent: "#cba6f7",
            accentDim: "#b4befe",
            active: "#a6e3a1",
            border: "#45475a",
            borderFocus: "#f5c2e7",
            error: "#f38ba8",
            warning: "#f9e2af",
            success: "#a6e3a1",
            info: "#89b4fa"
        },
        "Gruvbox": {
            background: "#282828",
            surface: "#3c3836",
            text: "#ebdbb2",
            textMuted: "#a89984",
            textActive: "#fbf1c7",
            textBright: "#fe8019",
            accent: "#d3869b",
            accentDim: "#b16286",
            active: "#b8bb26",
            border: "#504945",
            borderFocus: "#d3869b",
            error: "#fb4934",
            warning: "#fabd2f",
            success: "#b8bb26",
            info: "#83a598"
        },
        "TokyoNight": {
            background: "#1a1b26",
            surface: "#24283b",
            text: "#c0caf5",
            textMuted: "#565f89",
            textActive: "#ffffff",
            textBright: "#7dcfff",
            accent: "#bb9af7",
            accentDim: "#9d7cd8",
            active: "#9ece6a",
            border: "#414868",
            borderFocus: "#7aa2f7",
            error: "#f7768e",
            warning: "#e0af68",
            success: "#9ece6a",
            info: "#7dcfff"
        },
        "SolarizedDark": {
            background: "#002b36",
            surface: "#073642",
            text: "#839496",
            textMuted: "#586e75",
            textActive: "#93a1a1",
            textBright: "#fdf6e3",
            accent: "#268bd2",
            accentDim: "#2aa198",
            active: "#859900",
            border: "#586e75",
            borderFocus: "#268bd2",
            error: "#dc322f",
            warning: "#b58900",
            success: "#859900",
            info: "#2aa198"
        },
        "RosePine": {
            background: "#191724",
            surface: "#1f1d2e",
            text: "#e0def4",
            textMuted: "#6e6a86",
            textActive: "#ffffff",
            textBright: "#9ccfd8",
            accent: "#c4a7e7",
            accentDim: "#ebbcba",
            active: "#31748f",
            border: "#26233a",
            borderFocus: "#ebbcba",
            error: "#eb6f92",
            warning: "#f6c177",
            success: "#31748f",
            info: "#9ccfd8"
        },
        "Plum": {
            background: "#14111a",
            surface: "#6b5e72",
            text: "#d8d0dc",
            textMuted: "#c3a5ca",
            textActive: "#14111a",
            textBright: "#e7dfe9",
            accent: "#a87692",
            accentDim: "#8d5f74",
            active: "#b57a92",
            border: "#6b5e72",
            borderFocus: "#8d5f74",
            error: "#94abd1",
            warning: "#c994b3",
            success: "#94d1ab",
            info: "#7e95c1"
        }
    })

    onActiveThemeChanged: applyTheme(activeTheme)
    Component.onCompleted: applyTheme(activeTheme)

    function applyTheme(name) {
        let t = palettes[name];
        if (!t) {
            console.warn("Theme not found: " + name);
            return;
        }
        background = t.background;
        surface = t.surface;
        text = t.text;
        textMuted = t.textMuted;
        textActive = t.textActive;
        textBright = t.textBright;
        accent = t.accent;
        accentDim = t.accentDim;
        active = t.active;
        border = t.border;
        borderFocus = t.borderFocus;
        error = t.error;
        warning = t.warning;
        success = t.success;
        info = t.info;
    }
}

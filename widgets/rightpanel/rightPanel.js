function exportLinks(nameField, exportProcess, textArea) {
  let fileName = nameField.text.trim();
  let fileContent = textArea.text;

  if (fileName === "") {
    let date = new Date();
    let pad = (n) => String(n).padStart(2, '0');
    let timestamp = date.getFullYear() + "-" +
      pad(date.getMonth() + 1) + "-" +
      pad(date.getDate()) + "_" +
      pad(date.getHours()) + "-" +
      pad(date.getMinutes()) + "-" +
      pad(date.getSeconds());
    fileName = "links_" + timestamp;
  } else {
    fileContent = `=== ${fileName}\n${textArea.text}`;
  }

  // Make sure it always ends with .txt
  if (!fileName.endsWith(".txt")) {
    fileName += ".txt";
  }

  let exportPath = Quickshell.env("HOME") + "/AppData/Configs/Default/Links/" + fileName;

  exportProcess.command = ["sh", "-c", "printf '%s' \"$1\" > \"$2\"", "_", fileContent, exportPath];
  exportProcess.running = true;

  // Clear the text inputs
  textArea.text = "";
  nameField.text = "";
}

function exportLinks(nameField, exportProcess, textArea) {
  let fileName = nameField.text.trim();
  if (fileName === "") {
    let date = new Date();
    let pad = (n) => String(n).padStart(2, '0');
    let timestamp = date.getFullYear() + "-" +
      pad(date.getMonth() + 1) + "-" +
      pad(date.getDate()) + "_" +
      pad(date.getHours()) + "-" +
      pad(date.getMinutes()) + "-" +
      pad(date.getSeconds());
    fileName = "links_" + timestamp + ".txt";
  }

  let exportPath = Quickshell.env("HOME") + "/AppData/Configs/Default/Links/" + fileName;

  exportProcess.command = ["sh", "-c", "printf '%s' \"$1\" > \"$2\"", "_", textArea.text, exportPath];
  exportProcess.running = true;

  textArea.text = "";
  nameField.text = "";
}
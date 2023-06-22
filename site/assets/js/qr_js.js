var qrcode = new QRCode(document.getElementById("qrcode"),{
  text: <?= json_encode($_SESSION['userqr']['first_name']) ?>,
  width: 400,
  height: 400,
  colorDark: "#000",
  colorLihgt:"#fff",
  correctLevel: QRCode.CorrectLevel.H
});

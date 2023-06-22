// в этом примере я использую фразу "Привет, мир!" вместо вашего реального текста
$text = 'Привет, мир!';
?>

if (document.getElementById("qrcode").innerHTML == '') {
  var qrcode = new QRCode(document.getElementById("qrcode"),{
    text: <?php echo json_encode($text); ?>,
    width: 400,
    height: 400,
    colorDark: "#000",
    colorLihgt:"#fff",
    correctLevel: QRCode.CorrectLevel.H
  });
  document.getElementById("opened").innerHTML = "QR-код успешно создан";
}
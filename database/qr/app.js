function str_rand() {
        var result = '';
        var words= '0123456789qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM';
        var max_position = words.length - 1;
            for( i = 0; i < 20; ++i ) {
                position = Math.floor ( Math.random() * max_position );
                result = result + words.substring(position, position + 1);
            }
        return result;
    };
var a = str_rand();

alert(a);

var qrcode = new QRCode(document.getElementById("qrcode"),{
	text: a,
	width:400,
	height:400,
	colorDark: "#000",
	colorLihgt:"#fff",
	correctLevel: QRCode.CorrectLevel.H
})

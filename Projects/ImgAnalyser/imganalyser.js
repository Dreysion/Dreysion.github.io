s=new Image();
src="sample.jpg";
s.src=src;
//s.crossOrigin="anonymous";

function loadStuff(){
	body=document.getElementById("body");
	
	c=document.getElementById("canvas");
	ctx=c.getContext("2d");
	
	drawImage(s);
	getData(s);
}

function drawImage(img){
	ctx.clearRect(0,0,c.width,c.height);
	c.width=img.width;
	c.height=img.height;
	ctx.drawImage(img,0,0);
}

function getData(img){
	datums=c.toDataURL();
	console.log(datums);
	imgData=ctx.getImageData(0,0,c.width,c.height);
	//cannot simply take an image from a website anymore
	//also cannot take data from image from file without allowing it in browser
	//would probably work if files are stored online and s.crossOrigin is not commented out
	for(i=0;i<imgData.data.length;i+=4){
		console.log(imgData.data[i]+" "+imgData.data[i+1]+" "+imgData.data[i+2]+"<br>");
	}
}

function switchit(){
	srcold=s.src;
	
	if(src=="sample.jpg"){
		src="sample2.png";
	}else{
		src="sample.jpg";
	}
	s.src=src;
	s.onload=function(){
		getData(s);
		drawImage(s);
	};		
}
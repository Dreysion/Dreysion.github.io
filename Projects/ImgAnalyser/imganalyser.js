s=new Image();
src="sample.jpg";
s.src=src;

function loadStuff(){
	body=document.getElementById("body");
	
	c=document.getElementById("canvas");
	ctx=c.getContext("2d");
	
	working=false;
	
	drawImage(s);
}

function drawImage(img){
	ctx.clearRect(0,0,c.width,c.height);
	c.width=img.width;
	c.height=img.height;
	ctx.drawImage(img,0,0);
}

function getData(){ //still figuring this stuff out, I'm new at it
	if(!working){
		working=true;
		var startTime = performance.now();
		console.log("working...");
		//datums=c.toDataURL();
		//console.log(datums);
		imgData=ctx.getImageData(0,0,c.width,c.height);
	//cannot get image data from a website anymore unless preauthorized
	//also cannot take data from image from file without allowing it in browser manually first (not advised)
	//only works if using a server to run these files, not if running html from desktop
		for(i=0;i<imgData.data.length;i+=4){
			document.getElementById("test").innerHTML=i;
			console.log(imgData.data[i]+" "+imgData.data[i+1]+" "+imgData.data[i+2]);
			if(i==imgData.data.length-4){
				working=false;
				var endTime = performance.now();
				console.log("done in "+(endTime-startTime)+" ms");}
		}
	}
}

function switchit(){ //temporary function, won't be utilized in final project
	if(src=="sample.jpg"){
		src="sample2.png";
	}else{
		src="sample.jpg";
	}
	s.src=src;
	s.onload=function(){
		drawImage(s);
	};		
}

function useUploaded(){
	u=document.getElementById("uploaded").value;
	src=u;
	s.src=src;
	s.onload=function(){
		drawImage(s);   //doesn't work, need to use php or asp or something to make connection private and secure
	}
}
  //拖动
  function Drag(table){
    var ochek=document.getElementById("chenkbox"),
        otable=document.getElementById(table),
        otody=otable.tBodies[0],
        oth=otody.getElementsByTagName("th"),
        otd=otody.getElementsByTagName("td"),
        box=document.getElementById("box"),
        arrn=[];
        for (var i = 0; i < otd.length; i++) {
          otd[i].onmousedown=function(e){
              var e=e||window.event,
                  target = e.target||e.srcElement,
                  thW = target.offsetWidth,
                  maxl=ochek.offsetWidth-thW,
                  rows=otable.rows,
                  ckL=ochek.offsetLeft,
                  disX=target.offsetLeft,
                  _this=this,
                  cdisX=e.clientX-ckL-disX;
                  for (var i = 0; i < rows.length; i++) {
                      var op=document.createElement("p");
                      op.innerHTML=rows[i].cells[this.cellIndex].innerHTML;  
                      box.appendChild(op);
                  };    
                  for (var i = 0; i < oth.length; i++) {
                         arrn.push(oth[i].offsetLeft);      
                  }; 
                  console.log(arrn);
                  box.style.display="block";
                  box.style.width=thW+"px";
                  box.style.left=disX+"px";
                  //未完成 还有事件没写。
                  document.onmousemove=function(e){
                      var e=e||window.event,
                      target = e.target||e.srcElement,
                      thW = target.offsetWidth;
                      box.style.top=0;
                      box.style.left=e.clientX-ckL-cdisX+"px";
                      if(box.offsetLeft>maxl){
                           box.style.left=maxl+"px";
                      }else if(box.offsetLeft<0){
                           box.style.left=0;
                      }        
                      document.onselectstart=function(){return false};     
                    window.getSelection ? window.getSelection().removeAllRanges() : doc.selection.empty();              
                  }
                  document.onmouseup=function(e){
                     var index;
                     var e=e||window.event,
                         opr=box.getElementsByTagName("p"),
                         oboxl=box.offsetLeft+cdisX;
                        for (var i = 0; i < arrn.length; i++) {
                           if(arrn[i]<oboxl){
                            index=i;
                           }
                        };
                       for (var i = 0; i < rows.length; i++) {
                          var oldw = rows[i].cells[_this.cellIndex].style.width;
                          var oldn = rows[i].cells[index].style.width;
                          rows[i].cells[index].style.width = oldw;
                          rows[i].cells[_this.cellIndex].style.width = oldn;
                          rows[i].cells[_this.cellIndex].innerHTML="";
                          rows[i].cells[_this.cellIndex].innerHTML=rows[i].cells[index].innerHTML;
                          rows[i].cells[index].innerHTML="";
                          rows[i].cells[index].innerHTML=opr[i].innerHTML;
                       };
                       box.innerHTML="";
                       arrn.splice(0,arrn.length);
                       box.style.display="none";
                       document.onmousemove=null; 
                       document.onmouseup=null;
                       document.onselectstart=function(){return false};
                  }

             }
        };
        
  }
  Drag("simple-table");
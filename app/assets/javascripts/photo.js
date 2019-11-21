 $(document).ready(
  function(){
    $('img.close').click(
      function(){
        $(this).parent().parent().empty();
      });
    $('img.closes').click(
      function(){
        if(document.getElementById("addImg").style.display = "none")
        {
          document.getElementById("addImg").style.display = "inline"
        }
        $(this).parent().parent().empty();
      });
  })

 function showImage(){
  if(this.files && this.files[0])
  {
    var obj = new FileReader();
    obj.onload = function(data){
     $('.images').prepend(' <div class="img float-left mt-2 mr-1"><div ng-repeat="file in imagefinaldata" class="img_wrp"><img style="height: 180px;width:180px" src="' + data.target.result + '" class="imgResponsiveMax" alt="" /><img class="close m-1" src="/assets/cl.png" onClick="click()"style="width:30px; height: 30px" /></div></div> ');
     $('.upload-btn-wrapper').css({ display: "none" });
     $(document).ready(
      function(){
        $('img.close').click(
          function(){
            $(this).parent().parent().empty();
            $('.upload-btn-wrapper').css({ display: "block" });
          })
      })
   }
   obj.readAsDataURL(this.files[0]);
 }
}
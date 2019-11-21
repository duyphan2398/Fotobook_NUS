  $(document).ready(function(){

    $('img.show-modal-photo').on('click', function () {
      var image = $(this).attr('src');
      var name = $(this).attr('name');
      var title = $('b[name='+name+']').text();
      var description = $('p[name='+name+']').text();
      //alert(image);
      $('#myModal').on('show.bs.modal', function () {
        $(".modalPhoto").attr("src", image);
        $(".modal-title").text(title);
        $(".modal-content-photo").text(description);
      });
    });

    $('div.show-modal-album').on('click', function () {
      var name = $(this).attr('name');
      var pics = $('img[name='+name+']')
      var title = $('b[name='+name+']').text();
      var description = $('p[name='+name+']').text();
      //alert(image);
      $('#modalAlbum').on('show.bs.modal', function () {
        pics.each(function(index,item){
          if(index == 0) {
            $('.modalAlbum').html('<div class="carousel-item active" style="overflow:hidden; text-align: center;"><img class="modalAlbumImg" src="'+item.src+'" ></div>');
          }
          else {
            $('.modalAlbum').append('<div class=" carousel-item"><img class="modalAlbumImg" src="'+item.src+'" ></div>');
          }
        })
        $(".modal-title-album").text(title);
        $(".modal-content-album").text(description);
      });
    });

    $("img.album").each(function(){
      if($(this).is(":first-of-type") || $(this).is(":nth-of-type(2)")) {
        if ($(this).is(":first-of-type"))
          $(this).css("z-index" ,"10");
        else
          $(this).css("z-index" ,"2");
        count = 0;
      }
      else{
        count++;
        $(this).css("z-index" ,"0");
        $(this).css("transform" ,"rotate("+count*10+"deg)");
      }
    })

    /*Nút like */
    $('img.like').click(function(){
      if($(this).attr('src')=="./assets/heart.png")
      {
        $(this).removeAttr("src");
        $(this).attr('src',"./assets/like.png");
      }
      else
      {
        $(this).removeAttr("src");
        $(this).attr("src","./assets/heart.png");
      }
    });







  });

  /*Mở tab*/
  function openTab(evt, tabName) {
    var i, tabcontent, tablinks;
    tabcontent = document.getElementsByClassName("tabcontent");
    for (i = 0; i < tabcontent.length; i++) {
      tabcontent[i].style.display = "none";
    }
    tablinks = document.getElementsByClassName("tablinks");
    for (i = 0; i < tablinks.length; i++) {
      tablinks[i].className = tablinks[i].className.replace(" active", "");
    }
    document.getElementById(tabName).style.display = "block";
    evt.currentTarget.className += " active";
  }


  /*Chon Album*/
  function choose() {
    // Photo preview on album create
    var preview = $("#image-preview");
    $("#images_").change(function(event){
     var input = $(event.currentTarget);
     var files = input[0].files;

     for (var i = 0; i < files.length; i++){
      var file = files[i]
      var reader = new FileReader();
      reader.onload = function(e){
       image_base64 = e.target.result;
       var html = ' <div class="img float-left mt-2 mr-1"><div ng-repeat="file in imagefinaldata" class="img_wrp" class=""><img style="height: 180px;width:180px" src="' + image_base64 + '" class="imgResponsiveMax" alt="" />'
       preview.append(html);
     };
     reader.readAsDataURL(files[i]);
   };
 });
    // Clear images when Browse is clicked again
    $("#images_").click(function(){
      $("#image-preview img").remove();
    });
  }






  // Follow and Unfollow
  $(".follow").click(function() {

    follower_id = $(this).attr('follower_id');
    following_id = $(this).attr('following_id');
    name = $(this).attr('name');
    follow = $('[name='+name+']');
    console.log(follow);
    if ($(this).attr("followed") == "false") {
      Rails.ajax({
        url: "/follow",
        contentType: "application/json",
        type: "post",
        dataType: "json",
        data: $.param({ follower_id: follower_id, following_id: following_id }),

                // data: "follower_id=>cc, following_id=>ccc",
                success: function(data) {
                  follow.each(function(index,item){
                    $(follow).removeClass("follower");
                    $(follow).addClass("following");
                    $(follow).text("Unfollow");
                    $(follow).attr("followed", "true");
                  })

                },
                error: function(data) {
                  alert(data)
                }
              });
    } else {
      Rails.ajax({
        url: "/unfollow",
        contentType: "application/json",
        type: "post",
        dataType: "json",
        data: $.param({ follower_id: follower_id, following_id: following_id }),

                // data: "follower_id=>cc, following_id=>ccc",
                success: function(data) {
                  follow.each(function(){
                    $(follow).removeClass("following");
                    $(follow).addClass("follower");
                    $(follow).text("Follow");
                    $(follow).attr("followed", "false");
                  })

                },
                error: function(data) {
                  alert(data)
                }
              });}
    });

  $('.likes').on('ajax:success', function() {
    var count;
    var count, name;
    name = $(this).attr('name');
    if ($('a[name="'+name+'"]').attr('flag') === '1') {
      $(this).attr('flag', '0');
      $(this).html('<img class="like" src="./assets/like.png">');
      count = parseInt($('p[name="'+name+'"]').text());
      console.log($('p[name="'+name+'"]'));
      count++;
      console.log(count);
      $('p[name="'+name+'"]').text(count);
    } else {
      $(this).attr('flag', '1');
      $(this).html('<img class="like" src="./assets/heart.png">');
      count = parseInt($('p[name="'+name+'"]').text());
      count--;
      console.log(count);
      console.log($('p[name="'+name+'"]').text());
      $('p[name="'+name+'"]').text(count);
    }
  });
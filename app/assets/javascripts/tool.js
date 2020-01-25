document.addEventListener("turbolinks:load", function() {
  (function() {
    var replaceSelectOptions = function($select, results) {
      $select.html($('<option>'));
      $.each(results, function() {
        var option = $('<option>').val(this.concreteMethod).text(this.concreteMethod);
        $select.append(option);
      });
    };

    //Ajaxリクエスト時のエラー処理
    var errorFunc = function(XMLHttpRequest, textStatus, errorThrown) {
      console.error("Error occurred in replaceChildrenOptions");
      console.log(`XMLHttpRequest: ${XMLHttpRequest.status}`);
      console.log(`textStatus: ${textStatus}`);
      console.log(`errorThrown: ${errorThrown}`);
    }

    var replaceChildrenOptions = function() {
      //選択された親カテゴリのオプションから、data-children-pathの値を読み取る
      var childrenPath = $(this).find('option:selected').data().childrenPath;
      //子カテゴリのセレクトボックスを取得する
      var $selectChildren = $(this).closest('form').find('.select-children');
      if (childrenPath != null) {
        //childrenPathが存在する = 親カテゴリが選択されている場合ajaxでサーバーに子カテゴリの一覧を問い合わせる
        $.ajax({
          url: childrenPath,
          dataType: "json",
          type: "GET",
          success: function(results) {
            //サーバーから受け取った子カテゴリの一覧でセレクトボックスを置き換える。
            replaceSelectOptions($selectChildren, results);
          },
          error: errorFunc
        });
      } else {
        //親カテゴリが未選択だったので、子カテゴリの選択肢をクリアする
        replaceSelectOptions($selectChildren, []);
      }
    };

    //変換結果出力
    var inputResultConv = function(results) {
      $.each(results, function() {
        if (results[0]["conv_word"] || results[0]["conv_word"] == ""){
          $('#inputMethodName').text(this.conv_word);
        } else {
          $('#inputClassName').val(this.conv_other_camel);
          $('#inputVariable').val(this.conv_other_downcase);
          $('#inputFix').val(this.conv_other_upcase);
        }
      });
    };

    var convertWords = function() {
      $form = $(this).parents('form:first');
      $.ajax({
        url: $form.attr('action'),
        type: $form.attr('method'),
        dataType: "json",
        data: $form.serialize(),
        success: function(results) {
          //サーバーから受け取った変換結果を出力する。
          inputResultConv(results);
        },
        error: errorFunc
      });
    };

    //親カテゴリ変更時のイベント
    $('.select-parent').on({
      'change': replaceChildrenOptions
    });

    //各フィールド変更時のイベント
    $('.change_field').on({
      'change': convertWords
    });

  })();
});
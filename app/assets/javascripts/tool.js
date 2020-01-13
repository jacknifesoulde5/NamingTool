document.addEventListener("turbolinks:load", function() {
  return (function() {
    var replaceChildrenOptions, replaceSelectOptions;
    replaceSelectOptions = function($select, results) {
      $select.html($('<option>'));
      return $.each(results, function() {
        var option;
        option = $('<option>').val(this.id).text(this.concreteMethod);
        return $select.append(option);
      });
    };

    replaceChildrenOptions = function() {
      var $selectChildren, childrenPath;
      //選択された親カテゴリのオプションから、data-children-pathの値を読み取る
      childrenPath = $(this).find('option:selected').data().childrenPath;
      //子カテゴリのセレクトボックスを取得する
      $selectChildren = $(this).closest('form').find('.select-children');
      if (childrenPath != null) {
        //childrenPathが存在する = 親カテゴリが選択されている場合ajaxでサーバーに子カテゴリの一覧を問い合わせる
        return $.ajax({
          url: childrenPath,
          dataType: "json",
          success: function(results) {
            //サーバーから受け取った子カテゴリの一覧でセレクトボックスを置き換える。
            return replaceSelectOptions($selectChildren, results);
          },
          error: function(XMLHttpRequest, textStatus, errorThrown) {
            console.error("Error occurred in replaceChildrenOptions");
            console.log(`XMLHttpRequest: ${XMLHttpRequest.status}`);
            console.log(`textStatus: ${textStatus}`);
            return console.log(`errorThrown: ${errorThrown}`);
          }
        });
      } else {
        //親カテゴリが未選択だったので、子カテゴリの選択肢をクリアする
        return replaceSelectOptions($selectChildren, []);
      }
    };

    //親カテゴリ変更時のイベント
    return $('.select-parent').on({
      'change': replaceChildrenOptions
    });
  })();
});
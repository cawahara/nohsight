
# Vue template
$ ->
   Vue.component('my-component', {
         template: '<div>A custom component</div>'
      }
   )

   new Vue(
      el: '#event-programs-plus',

   )
# 1. Event_programとTicketsで新規項目の追加
# 2. 同テンプレート上で削除、編集(と完了)を終えること
# 3. 上記のアクション群を反映したモデルの上書きは最下部の「保存」ボタンによってまとめて実行される

# 4. モデル検索機能を実装(とりあえず何か入力したら候補がでてくるように)
# 5. 候補から見つけた場合、他の項目は編集できないように設定する


# 6. Event/showにおいて、周辺スポット紹介はユーザが見たい演目をクリックしたときに起動(APIリクを送る)

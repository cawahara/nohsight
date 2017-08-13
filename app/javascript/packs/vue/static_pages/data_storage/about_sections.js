class Article{
   constructor(header, sections){
      this.header = header
      this.sections = sections
   }
}

class Section{
   constructor(header, contents){
      this.header = header
      this.contents = contents
   }
}

class Content{
   constructor(tag, resource){
      this.tag = tag
      this.resource = resource
   }
}

var articles = [
   new Article(
      '～初めての方へ～',
      [
         new Section('～気軽に能楽に触れてもらうために～',
                     [
                        new Content('p', '深い歴史を持つ能は世界でも注目を集める伝統芸能です。このサービスは、少しでも能楽の世界に触れる機会を作れればという思いから生まれました。')
                     ]
         ),
         new Section('～多い情報から簡単に見つかる～',
                     [
                        new Content('p', '日本全国75カ所の能舞台で行われる公演の数は非常に多いです。その中から、演目や演者など気になるワードを条件に興味のある公演情報を簡単に探すことができます。')
                     ]
         ),
         new Section('～自分たちで公演を発信していく～',
                     [
                        new Content('p', 'Noh-Event(仮)ではユーザが誰でも公演情報を登録・編集できるようになっています。これをきっかけにユーザ同士が交流できればと考えております。積極的に見つけた能楽の催し・イベントの情報を登録していきましょう。')
                     ]
         )
      ]
   )
]

export default { articles }

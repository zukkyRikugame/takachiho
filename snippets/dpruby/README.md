# Design Pattern in Ruby
結城浩「Java言語で学ぶデザインパターン入門」のサンプルプログラムをRubyに移植したコードです。オリジナルのコード(Java)は著者のサイトから入手可能です。

http://www.hyuki.com/dp/

起業してしばらくはJava一筋で頑張ってきましたが、徐々に限界を感じるようになってきました。最近ではRubyやPython,PHPを触ることが多いです。


## メモ


require_relative の方法。

## まとめてロード(reqire)する
```
Dir[File.expand_path('../commands', __FILE__) << '/*.rb'].each do |file|
  require file
end
```
http://kurochan-note.hatenablog.jp/entry/2014/02/15/235706

### to_i か Integer か？
to_iを使うと、数値に変換できない文字列は「0」として扱われます。不正な文字が入った時にはエラーとして処理したい場合には、以下のような構文を利用します。

```
Integer(current_token)
```
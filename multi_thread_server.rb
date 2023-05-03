# 複数のリクエストを同時に処理するサーバ
require 'socket'

$counter = 0     # スレッド間で共有されるグローバル変数
Thread.current[:name] = 'Main'   # スレッド間で共有されるThread.current変数

server = TCPServer.new('localhost', 8080)

loop do
  Thread.start(server.accept) do |client|
    Thread.current[:name] = 'Worker'  # スレッド間で共有されるThread.current変数を更新する
    $counter += 1   # スレッド間で共有されるグローバル変数を更新する

    GC.start
    client.puts "Hello, world! (#{$counter})"   # スレッドがリクエストを処理する
    client.puts "スレッド数: #{Thread.list.size}"
    sleep 10
  end
end

# 単一のスレッドで動作するサーバー
# 複数のクライアントからリクエストを受け付けることはできない
require 'socket'

server = TCPServer.new 2000
i = 0
loop do
  client = server.accept
  p client
  client.puts "Hello #{Time.now} counter:#{i}"
  i += 1
end

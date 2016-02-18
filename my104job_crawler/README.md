# My104jobCrawler

**104 jobs list dump 小幫手**

## 第一次使用？
```
  mix do deps.get, compile
  #請設定環境變數設置psql的帳號密碼 or 更改 config/config.ex
  mix do ecto.create, ecto.migrate
  # 執行job!
  iex -S mix
  iex(1)> Crawler.Controller.getdata
```

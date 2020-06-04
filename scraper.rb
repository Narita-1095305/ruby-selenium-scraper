# ==================
# gemの読み込み
# ==================
require "csv"
require 'selenium-webdriver'

@wait_time = 100
@timeout = 101


# Seleniumの初期化
# class ref: https://www.rubydoc.info/gems/selenium-webdriver/Selenium/WebDriver/Chrome
Selenium::WebDriver.logger.output = File.join("./", "selenium.log")
Selenium::WebDriver.logger.level = :warn
driver = Selenium::WebDriver.for :chrome
driver.manage.timeouts.implicit_wait = @timeout
wait = Selenium::WebDriver::Wait.new(timeout: @wait_time)

#csvに情報を書き込む。
CSV.open('.csv','a') do |csv|
	#スクレイピングしたいサイトをここに入力
	url = ""
	# Yahooを開く
	driver.get(url)

	# ちゃんと開けているか確認するため、sleepを入れる
	sleep 2

	#**
	  # ブラウザでさせたい動作を記載する

	  # 要素が表示されるまで待つ
	wait.until {
		driver.find_element(:xpath, "").displayed?
	}

	temp = driver.find_element(:xpath, "")

	#タグの要素を引っ張りたいならこれを使う。いらないならコメントアウトする。
	link = temp.attribute('href')
	csv << [link]
	puts link
	sleep 3
end

# ドライバーを閉じる
driver.quit

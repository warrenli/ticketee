# language: zh-TW

功能: 建立新專案
  為了可以將工作單配給專案
  作為一名用戶
  我須要容易地建立專案

  背景:
    假設 選用 中文
    假設 有一位管理員電郵地址是"admin@ticketee.com"密碼是"password"
    而且 "admin@ticketee.com"已確認帳戶
    而且 已成功登入系統
    假設 我來到首頁
    當 我按下鏈接"新專案"

  場景: 建立專案
    而且 在"專案名稱"欄位中輸入"大中華"
    而且 按下了"建立 專案"按钮
    那麼 我應該看到"新專案已成功建立。"的提示信息
    而且 我停留在專案"大中華"
    而且 我應該看到"大中華 - Projects - Ticketee"

  場景: 建立沒有名稱的專案
    而且 按下了"建立 專案"按钮
    那麼 我應該看到"專案未能建立。"
    而且 我應該看到"專案名稱 不能是空白字元"

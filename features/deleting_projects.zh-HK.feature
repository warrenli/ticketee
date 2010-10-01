# language: zh-TW

功能: 刪除專案
  為了可以刪除不須要的專案
  作為一名專案管理員
  我可以將不須要的專案刪除

  背景:
    假設 選用 中文
    假設 有一位管理員電郵地址是"admin@ticketee.com"密碼是"password"
    而且 "admin@ticketee.com"已確認帳戶
    而且 已成功登入系統

  場景: 刪除一個專案
    假設 有一個名稱為"大中華"的專案
    而且 我來到首頁
    當 我按下鏈接"大中華"
    而且 按下鏈接"刪除"
    那麼 我應該看到"專案已刪除。"
    那麼 我應該不會看到"大中華"

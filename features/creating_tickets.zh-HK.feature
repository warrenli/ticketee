# language: zh-TW

功能: 建立新工作單
  為了可以建立新的專案工作單
  作為一名用戶
  我可以選用個別專案然後建立新工作單

  背景:
    假設 選用 中文
    假設 有一個名稱為"大中華"的專案
    而且 有一位帳戶電郵地址是"user@ticketee.com"密碼是"password"
    而且 "user@ticketee.com"可以閱讀"大中華"專案
    而且 "user@ticketee.com"可以建立"大中華"專案的工作單
    而且 已成功登入系統
    而且 我來到首頁
    當 我按下鏈接"大中華"
    而且 按下鏈接"新工作單"

  場景: 建立工作單
    當 在"標題"欄位中輸入"籌款"
    而且 在"明細"欄位中輸入"通過各種渠道和採用不同方式籌集必需的資金"
    而且 按下了"建立 工作單"按钮
    那麼 我應該看到"工作單已成功建立。"
    而且 我應該看到"user@ticketee.com 建立這工作單"

  場景: 建立沒有名稱的專案
    當 按下了"建立 工作單"按钮
    那麼 我應該看到"工作單未能建立。"
    而且 我應該看到"標題 不能是空白字元"
    而且 我應該看到"明細 不能是空白字元"

  場景: 明細必須多個十個字元
    當 在"標題"欄位中輸入"籌款"
    而且 在"明細"欄位中輸入"資金籌措"
    而且 按下了"建立 工作單"按钮
    那麼 我應該看到"工作單未能建立。"
    那麼 我應該看到"明細 過短（最短是 10 個字）"

  場景: 建立包含附加物的工作單
    當 在"標題"欄位中輸入"籌款"
    而且 在"明細"欄位中輸入"通過各種渠道和採用不同方式籌集必需的資金"
    而且 加入附加文件檔"spec/fixtures/speed.txt"到欄位"檔案 #1"
    而且 加入附加文件檔"spec/fixtures/spin.txt"到欄位"檔案 #2"
    而且 加入附加文件檔"spec/fixtures/gradient.txt"到欄位"檔案 #3"
    而且 按下了"建立 工作單"按钮
    那麼 我應該看到"工作單已成功建立。"
    而且 我應該看到"speed.txt" 包含在"#ticket .assets"
    而且 我應該看到"spin.txt" 包含在"#ticket .assets"
    而且 我應該看到"gradient.txt" 包含在"#ticket .assets"

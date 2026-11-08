# External Clock Generator for OCT

以 Verilog 實作並已完成驗證的 FPGA 外部取樣觸發模組，用於掃頻式光學同調斷層掃描（SS-OCT）。透過追蹤 MZI 參考干涉訊號的相位變化，產生對應等波數（equal-k）間距的觸發訊號，作為 OCT 資料取樣與重取樣的依據。

## 處理流程

```text
MZI 參考訊號 → DC 移除 → 低通濾波 → Hilbert 轉換 → CORDIC 相位計算 → 相位展開 → 取樣觸發
```

## 主要模組

| 模組 | 功能 |
| --- | --- |
| `ExternalClkGen_TOP` | 頂層整合與觸發輸出 |
| `DCremover` | 移除訊號直流成分 |
| `LPF_fixed` | 固定點 FIR 低通濾波 |
| `hilbert_iir` | 產生正交訊號，供相位估測使用 |
| `arctan_unwrap` | 串接 CORDIC、展開相位並產生等波數取樣觸發 |

## 專案結構

- `Verilog/new/`：Verilog 訊號處理模組。
- `Verilog/ip/`：Xilinx CORDIC IP 設定。
- `testbench/`：參考干涉訊號與 OCT 資料的模擬測試。

開發環境：Xilinx Vivado / Verilog。模擬時需自行提供測試資料並調整 testbench 中的檔案路徑。

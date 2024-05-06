# PS2 KEYBOARD in Computer Orgianzation


### 分工作業

- 1. Describe PS2 keyborad of Sample VHDL ( text ) in word file -- 劉卷姐
- 2. Describe PS2 keyborad of Sample VHDL ( figures ) in word file -- 賴文琪
- 3. Design Part of VHDL -- 陳羿錦
- 4. Testbench Part of VHDL -- 賴昱宏

### 先把自己的部分放在自己那部分的資料夾


# VHDL 計算機組織期末專題

## 專題題目：VHDL 實作 PS2 KeyBorad 架構與功能

### 專題分析

- #### 1. 了解 PS2 接口：PS2 接口是一種用於連接鍵盤和滑鼠的通用接口。要完成PS2鍵盤的設計，首先需要對PS2接口的工作原理有所了解，包括通信協議和信號傳輸方式。

- #### 2. 設計 PS2 接收器：設計一個 PS2 接收器模塊，用於從 PS2 鍵盤接收數據。這個模塊需要能夠解析 PS2 鍵盤發送的數據位和校驗位，並將其轉換為可用的數據格式。

- #### 3. 實現 ASCII 轉換：接收到的 PS2 碼需要轉換為 ASCII 碼，以便後續處理和顯示。這涉及到一個將 PS2 碼映射到對應 ASCII 字符的轉換表，以及設計一個模塊來執行這種轉換。

- #### 4. 鍵盤控制狀態：設計一個模塊來控制鍵盤的狀態，包括按鍵是否被按下以及按鍵的掃描和檢測。這個模塊需要跟踪鍵盤的按鍵狀態並提供相應的輸出信號。

- #### 5. FPGA 設計：將以上功能通過 VHDL 語言實現並在 FPGA 平台上部署。這涉及到將設計模擬並綜合到 FPGA 設備上，以實現 PS2 鍵盤的完整功能。

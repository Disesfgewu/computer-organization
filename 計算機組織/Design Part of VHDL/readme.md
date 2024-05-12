# Design Part of VHDL

## KeyBorad Implement 

### Structure 

#### Port

- 1. Data
- 2. Cloak -- T is about 60 to 100 per second ( f = 10 kHz to 16.7 kHz )
    ![Figure 8.1](image.png)
- 3. Vcc ( Voltage power supply ) = 5 v
- 4. Ground pin

![Figure 8.2 ASMD chart of the PS2 port receiver. ](image-1.png)

PS2 接口是一種用於連接鍵盤和滑鼠的通用接口，它包含以下幾個主要接口和信號：

Clock (CLK)：
說明：Clock信號是PS2接口的時鐘信號，它同步鍵盤和主機之間的數據傳輸。
作用：用於定時PS2通信協議中的數據傳輸，同步數據的接收和發送。
Data (DAT)：
說明：Data信號是PS2接口的數據傳輸信號，用於在鍵盤和主機之間傳輸數據。
作用：用於在PS2鍵盤和主機之間傳輸按鍵數據和控制信息。
Acknowledgment (ACK)：
說明：Acknowledgment信號是從主機到鍵盤的反饋信號，表示鍵盤已經成功接收到數據。
作用：用於確認PS2鍵盤已成功接收到主機發送的數據。
Reset (RST)：
說明：Reset信號是一種控制信號，用於重置PS2接口或設備。
作用：用於重置PS2鍵盤或主機的狀態，恢復到初始狀態。
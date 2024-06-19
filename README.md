#  📉 America Stock Information Application
## 미국 주식 정보를 제공하는 애플리케이션

## 📑 목차
- [개발 이유]
- [프로젝트 목표]
- [프로젝트 기능 설명]
- [프로젝트 구조]
- [느낀점]


## 🖇 개발 이유
올해 초, 주식을 처음 시작하게 되면서 주식 모의 투자 애플리케이션이 있다면 좋겠다고 생각했습니다.
그래서 주식 모의 투자 애플리케이션을 만들려고 구상했으나, 제 VMWare에서는 CocoaPods나 HomeBrew가
계속 설치 오류가 나서 방향을 틀게 되었습니다. 그리하여 주식을 알아보고 투자할 때 필요한 시세와 
재무제표, ESG 보고서, 관련 사이트나 영상을 하나로 모아보기로 하였습니다.

## 🔎 프로젝트 목표
- API 사용 익숙해지기
- 처음 주식을 시작하는 사람에게 유용한 정보 제공
- 주식 투자할 때 필요한 정보들

## 📂 프로젝트 기능 설명

### 1. 홈화면
#### 1-1. 검색 기능
![image](https://github.com/songjiyou/StockProject_2/assets/150700768/d77b5ea4-edd9-4dd2-a573-143b67c8147e)
- 홈화면에서 알아보고 싶은 기업의 Symbol을 입력하면 주식 시세가 나옵니다.


#### 1-2. 검색 결과
![image](https://github.com/songjiyou/StockProject_2/assets/150700768/92e37ea5-aafa-458c-b764-946012f3aade)
- 예를 들어서, APPLE의 'AAPL'을 입력하면 시세가 나오고 '과거 이력(HistroicData)'과 '재무제표(BalanceSheer)'와 ESG Report를 검색해 볼 수 있는 'Yahoo Finance' 홈페이지로 이동하는 버튼 3개가 나옵니다.


#### 1-3. Historic Data
![image](https://github.com/songjiyou/StockProject_2/assets/150700768/8d1b8fec-acab-49c3-8fda-731d62bd7303)
- 'HistoricData' 버튼을 누르면 과거 주식 가격들이 나옵니다.
- Navigation으로 연결하여 각 ViewController마다 상단에 'Back'이 나오며, 이것으로 홈화면 이동이 가능합니다.


#### 1-4. Balance Sheet
![image](https://github.com/songjiyou/StockProject_2/assets/150700768/b84381eb-9f5f-4b9f-9b36-56ccb4c4e6f7)
- 'BalanceSheet' 버튼을 누르면 재무제표와 관련된 정보들이 나옵니다. 'averageVolume' 평균거래량, 'dividendRate' 배당률, 'ask' 매도 호가 등 주식과 관련된 지표들이 나옵니다.


#### 1-5. ESG Report
![image](https://github.com/songjiyou/StockProject_2/assets/150700768/9dd8bb75-2d91-47d1-bba9-74b6a372632c)
- 'ESG Report'를 누르면 미국 주식 관련 정보를 제공하는 'Yahoo Finance' 홈페이지로 이동하여 관심 있는 기업에 대해 검색하고 정보를 획득할 수 있습니다.


#### 1-6. 하단 Toolbar
![홈화면_되돌리기](https://github.com/songjiyou/StockProject_2/assets/150700768/6d7461c5-01a5-4966-ac7c-8c32978e1ee0)
- 홈화면 하단에 돌아가는 기호를 누르면 검색했던 정보가 초기화됩니다.


### 2. Stock Site
![image](https://github.com/songjiyou/StockProject_2/assets/150700768/06604235-acf3-4f1a-91e8-470c27a42707)
- 홈화면 하단에 'Stock Site' 버튼을 누르면 기본적으로 Google 홈페이지가 뜨고 상단에는 검색할 수 있는 검색바와 그 밑에 유명한 미국 주식 관련 사이트 4개의 버튼을 누르면 홈페이로 이동할 수 있습니다.
- 하단에 화면 중지, 초기화, 뒤로 가기, 앞으로 가기 기호 버튼을 누르면 각 기능 이용 가능합니다.


#### 2-1. Investing
![image](https://github.com/songjiyou/StockProject_2/assets/150700768/22dd4483-7e39-491d-8d6f-c67a618245bc)
- 실시간 데이터와 광범위한 금융 시장 정보를 제공하는 것이 특징입니다.


#### 2-2. Seeking Alpha
![image](https://github.com/songjiyou/StockProject_2/assets/150700768/6fc07ade-b89a-4c5b-af58-84d5252fe2bb)
- 커뮤니티 중심으로 애널리스트들의 주식에 대한 분석을 볼 수 있고 사용자 맞춤형 포토폴리오를 작성할 수 있습니다.

  
#### 2-3. FINVIZ
![image](https://github.com/songjiyou/StockProject_2/assets/150700768/18decc62-360a-4ca7-82ba-f2968082528d)
- 다양한 시각적 도구가 특화되어 있으며, 'Heat Maps'을 이용해 많이 팔리는 주식에 대해 한 눈에 확인이 가능합니다.


#### 2-4. TradingView
![image](https://github.com/songjiyou/StockProject_2/assets/150700768/92df6f75-82a6-4d5b-a535-608f98cb2f11)
- 주식 차트가 크게 보여 관심있는 기업에 대해 빠르게 추세를 알 수 있고 다양한 금융 시장의 실시간 데이터와 연동됩니다.


#### 2-5. Seartbar + Search Button
![image](https://github.com/songjiyou/StockProject_2/assets/150700768/5342f5f6-f837-4ebf-80ff-5c9ec1e8d7d9)

- 검색바에 원하는 홈페이지 주소를 입력하면 이동도 가능합니다.


### 3. Stock Video
![image](https://github.com/songjiyou/StockProject_2/assets/150700768/08d7d8e3-3798-460e-ba73-1d72b1b0e139)

- 기본적으로 유튜브가 나오며, 밑에는 미국 주식 관련 링크를 추가하였습니다. 링크를 클릭하여 봐도 되고, 유튜브에 직접 검색하여 원하는 미국 주식 영상을 봐도 됩니다.


#### 3-1. 링크 영상
![image](https://github.com/songjiyou/StockProject_2/assets/150700768/7328102c-ee9c-495e-a75f-560a6c9886c0)
- 링크를 클릭하면 해당 영상으로 이동하여 재생됩니다.


### 4. 환율
![image](https://github.com/songjiyou/StockProject_2/assets/150700768/f26b055a-af45-46ec-8f48-d51415868e67)
- 홈화면 하단에 'Exchage' 버튼을 눌러 이동해서 창에 숫자를 입력 후 'USD Convert' 버튼을 누르면 해당 숫자의 원화가 나옵니다.


## ⛓️‍💥 프로젝트 구조
![구조](https://github.com/songjiyou/StockProject_2/assets/150700768/5a7d3be6-2d63-43f2-85f4-a89d8586ca29)


## 🔧 주요 기술
- API : 주식 관련 정보 API와 환율 API를 이용하여 구현
- WebView : 각종 사이트를 업로드하고 불러오기


## 💻 개발 도구
XCODE 


## 🎥 발표 영상
[![스크린샷 2024-06-19 194541](https://github.com/songjiyou/StockProject_2/assets/150700768/c5a68e36-f7d1-4cfb-b4da-4a60fcc3da97)](https://youtu.be/CQGhYMK7sxM)



## 💡 프로젝트를 하면서 느낀 점
- API 마다 지정해야 하는 메소드와 주소가 달라서 어려웠으나, 알아가는 재미가 컸습니다.
- 이번에는 무료 API를 이용하여 제한적인 데이터만 가능했지만 다음 번에는 유료 버전을 구매해 더 많은 주식 데이터와 실시간 데이터를 가져오고 싶습니다.
- 주식 관련 정보를 모으면서 개발 경험과 함께 미국 주식에 대해서도 더 깊이 알아보고 공부할 수 있어서 좋았습니다.



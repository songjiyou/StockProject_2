# America Stock Information Application
## 미국 주식 정보를 제공하는 애플리케이션

## 목차
- [개발 이유 및 목적]
- [기능]
- [구현 스크린샷 설명]
- [느낀점]

## 개발 이유
올해 초, 주식을 처음 시작하게 되면서 주식 모의 투자 애플리케이션이 있다면 좋겠다고 생각했습니다.
그래서 주식 모의 투자 애플리케이션을 만들려고 구상했으나, 제 VMWare에서는 CocoaPods나 HomeBrew가
계속 설치 오류가 나서 방향을 틀게 되었습니다. 그리하여 주식을 알아보고 투자할 때 필요한 시세와 재무제표, ESG 보고서, 관련 사이트나 영상을 하나로 모아보기로 하였습니다.

## 프로젝트 목표
- API 사용 익숙해지
- 처음 주식을 시작하는 사람에게 유용한 정보 제공
- 주식 투자할 때 필요한 정보들

## 프로젝트 기능 설명

### 1. 홈화면
#### 1-1. 
![image](https://github.com/songjiyou/StockProject_2/assets/150700768/d77b5ea4-edd9-4dd2-a573-143b67c8147e)
- 홈화면에서 알아보고 싶은 기업의 Symbol을 입력하면 시세가 나옵니다.
![image](https://github.com/songjiyou/StockProject_2/assets/150700768/92e37ea5-aafa-458c-b764-946012f3aade)
- 예를 들어서, APPLE의 'AAPL'을 입력하면 시세가 나오고 '과거 이력(HistroicData)'과 '재무제표(BalanceSheer)'와 ESG Report를 검색해 볼 수 있는 'Yahoo Finance' 홈페이지로 이동하는 버튼 3개가 나옵니다.
![image](https://github.com/songjiyou/StockProject_2/assets/150700768/8d1b8fec-acab-49c3-8fda-731d62bd7303)
- 'HistoricData' 버튼을 누르면 과거 주식 가격들이 나옵니다.
- Navigation으로 연결하여 각 ViewController마다 상단에 'Back'이 나오며, 이것으로 홈화면 이동이 가능합니다.
![image](https://github.com/songjiyou/StockProject_2/assets/150700768/b84381eb-9f5f-4b9f-9b36-56ccb4c4e6f7)
- 'BalanceSheet' 버튼을 누르면 재무제표와 관련된 정보들이 나옵니다. 'averageVolume' 평균거래량, 'dividendRate' 배당률, 'ask' 매도 호가 등 주식과 관련된 지표들이 나옵니다.
![image](https://github.com/songjiyou/StockProject_2/assets/150700768/9dd8bb75-2d91-47d1-bba9-74b6a372632c)
- 'ESG Report'를 누르면 미국 주식 관련 정보를 제공하는 'Yahoo Finance' 홈페이지로 이동하여 관심 있는 기업에 대해 검색하고 정보를 획득할 수 있습니다.
![홈화면_되돌리기](https://github.com/songjiyou/StockProject_2/assets/150700768/6d7461c5-01a5-4966-ac7c-8c32978e1ee0)
- 홈화면 하단에 돌아가는 기호를 누르면 검색했던 정보가 초기화됩니다.
![image](https://github.com/songjiyou/StockProject_2/assets/150700768/06604235-acf3-4f1a-91e8-470c27a42707)
- 홈화면 하단에 'Stock Site' 버튼을 누르면 기본적으로 Google 홈페이지가 뜨고 상단에는 검색할 수 있는 검색바와 그 밑에 유명한 미국 주식 관련 사이트 4개의 버튼을 누르면 홈페이로 이동할 수 있습니다.
- 하단에 화면 중지, 초기화, 뒤로 가기, 앞으로 가기 기호 버튼을 누르면 각 기능 이용 가능합니다.
#### Investing
![image](https://github.com/songjiyou/StockProject_2/assets/150700768/22dd4483-7e39-491d-8d6f-c67a618245bc)
- 실시간 데이터와 광범위한 금융 시장 정보를 제공하는 것이 특징입니다.
![image](https://github.com/songjiyou/StockProject_2/assets/150700768/6a7efd34-5937-4017-b311-5ef19b9a17b5)
#### Seeking Alpha
![image](https://github.com/songjiyou/StockProject_2/assets/150700768/6fc07ade-b89a-4c5b-af58-84d5252fe2bb)
- 커뮤니티 중심으로 애널리스트들의 주식에 대한 분석을 볼 수 있고 사용자 맞춤형 포토폴리오를 작성할 수 있습니다.
#### FINVIZ
![image](https://github.com/songjiyou/StockProject_2/assets/150700768/18decc62-360a-4ca7-82ba-f2968082528d)
- 다양한 시각적 도구가 특화되어 있으며, 'Heat Maps'을 이용해 많이 팔리는 주식에 대해 한 눈에 확인이 가능합니다.
![image](https://github.com/songjiyou/StockProject_2/assets/150700768/92df6f75-82a6-4d5b-a535-608f98cb2f11)
#### TradingView

- 주식 차트가 크게 보여 관심있는 기업에 대해 빠르게 추세를 알 수 있고 다양한 금융 시장의 실시간 데이터와 연동됩니다.

#### Seartbar + Search Button

- 검색바에 원하는 홈페이지 주소를 입력하면 이동도 가능합니다.
- 
### Stock Video

- 기본적으로 유튜브







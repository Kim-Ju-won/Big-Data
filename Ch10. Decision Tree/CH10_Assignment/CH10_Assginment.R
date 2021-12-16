#10 CarSale예측 .packages
#패키지 설치 및 로딩

# 패키지 설치 및 로딩
install.packages("C50")
library(C50)

#파일 읽기 
carsale <- read.csv(file.choose(), header =TRUE)
names(carsale)<-c("Id", "Choice", "Age", "zip", "Salary", "Credit", "House")

# Choice를 factor로 만들어주기
carsale$Choice <- as.factor(carsale$Choice)

# 데이터 분리를 위한 색인
# 150개 중에서 80프로를 train data 로 test data 를 20퍼센트 를 활용
# 랜덤 샘플링 set.seed() <- 샘플링의 결과를 고정 시켜줌(숫자를 통해서)
set.seed(3598)
# 랜덤하게 뽑힌 인덱스를 저장
idx <- sample(1:nrow(carsale), size = nrow(carsale)*0.8)
idx

length(idx)

# 데이터 분리
train_data <- carsale[idx,]
train_data

test_data <- carsale[-idx,]
test_data

#(모형 1) 가지치기 없는 경우
# 하나하나 보고 결정을 할건데, 웬만한 가지는 살릴 거야 
c5_options <- C5.0Control(noGlobalPruning = T, CF = 1)
model1 <- C5.0(Choice ~ ., 
               data = train_data[c("Choice", "Age", "zip", "Salary", "Credit", "House")], 
               control= c5_options)
summary(model1)

plot(model1)

#(모형 1) 지역적 가지치기
c5_options <- C5.0Control(noGlobalPruning = T, CF = 0.25)
model2 <- C5.0(Choice ~ ., 
               data = train_data[c("Choice", "Age", "zip", "Salary", "Credit", "House")], 
               control= c5_options)
summary(model2)

plot(model2)

#(모형 1) 전역적 가지치기 
c5_options <- C5.0Control(noGlobalPruning = F, CF = 1)
model3 <- C5.0(Choice ~ ., 
               data = train_data[c("Choice", "Age", "zip", "Salary", "Credit", "House")], 
               control= c5_options)
summary(model3)

plot(model3)

# 예측 
results1 <- predict(object = model1, newdata = test_data)
results1 

results2 <- predict(object = model, newdata = test_data)
results2 
results3 <- predict(object = model3, newdata = test_data)
results3 


# 예측 결과 검증 
table(results1, test_data$Choice)
table(results2, test_data$Choice)
table(results3, test_data$Choice)
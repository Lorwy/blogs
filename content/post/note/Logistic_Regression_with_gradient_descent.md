---
date: 2018-10-24
title: "运用梯度下降优化逻辑回归模型"
tags:
- Machine Learning
categories:
- ML
comment: false
---
# 逻辑回归简介
---
逻辑回归并不属于回归算法，而是经典的二分类算法，也可以处理多分类问题。


机器学习算法选择：先逻辑回归再用复杂的，能简单就用简单的
   

拿到一个分类问题，首选逻辑回归试试，看看效果如何，再用复杂的分类算法试试，看看是否有逻辑回归效果更好
   

注：**逻辑回归的决策边界：可以使非线性的**

# 具体算法
目标：建立分类器来求出 $\theta$

算法步骤：
- 实现 `sigmoid(z)` 函数
- 实现 `h(x)` 函数
- 从数据中提取出特征 `X` 和标签 `y`
- 实现 `cost function`
- 实现偏导数 `gradient()`
- 进行参数更新 `descent`
- 最后就求出了 $\theta$

## sigmoid函数
$$g(z) = \frac{1}{1+e^{-z}}$$

![](https://lorwy.github.io/image/sigmoid.png)

函数定义:
```python
def sigmoid(z):
    return 1 / (1 + np.exp(-z))
```
## h(x)
$$h(x) = \theta^T X$$

```python
def hx(X, theta):
    return sigmoid(np.dot(X, theta.T))
```
如：
$$
\begin{array}{ccc}
\begin{pmatrix}\theta_{0} & \theta_{1} & \theta_{2}\end{pmatrix} & \times & \begin{pmatrix}1\\
x_{1}\\
x_{2}
\end{pmatrix}\end{array}=\theta_{0}+\theta_{1}x_{1}+\theta_{2}x_{2}
$$

## 从数据中提取出特征 `X` 和标签 `y`
提取出 `X` 和 `y` 并根据 `X` 的shape来初始化 `theta`

## 实现损失函数 `cost function`
将对数似然函数去负号

$$
D(h_\theta(x), y) = -y\log(h_\theta(x)) - (1-y)\log(1-h_\theta(x))
$$
求平均损失
$$
J(\theta)=\frac{1}{m}\sum_{i=1}^{m} D(h_\theta(x_i), y_i)
$$

```python
def cost(X, y, theta):
    left = np.multiply(-y, np.log(hx(X, theta)))
    right = np.multiply(1, -y, np.log(1 - hx(X, theta)))
    return np.sum(left - right) / (len(X))
```

## 实现偏导数 `gradient()`计算梯度
$$
\frac{\partial J}{\partial \theta_j}=-\frac{1}{m}\sum_{i=1}^n (y_i - h_\theta (x_i))x_{ij}
$$
```python
def gradient(X, y, theta):
    grad = np.zeros(theta.shape)
    error = (hx(X, theta) - y).ravel()
    #print(theta.ravel())
    for j in range(len(theta.ravel())):
        term = np.multiply(error, X[:,j])
        grad[0,j] = np.sum(term) / len(X)
        
    return grad
```

## 实现descent方法，并进行Gradient descent
3种不同的梯度下降方法

- 批量梯度下降（Gradient descent）
- 随机梯度下降（stochastic Gradient descent）
- 小批量梯度下降（mini-bath Gradient descent）

3种不同的停止策略

- 循环次数达到阈值时
- 代价函数低于阈值时
- 梯度下降小于阈值时（$\varDelta \theta_j$）

```python
STOP_ITER = 0
STOP_COST = 1
STOP_GRAD = 2

# type：停止策略 value：当前值 threshold：阈值
def stopCriterion(type, value, threshold):
    if type == STOP_ITER:
        return value > threshold
    elif type == STOP_COST:
        return abs(value[-1] - value[-2]) < threshold
    elif type == STOP_GRAD:
        return np.linalg.norm(value) < threshold
    else:
        return YES
```

**打乱数据**
```python
import numpy.random
def shuffleData(data):
    np.random.shuffle(data)
    cols = data.shape[1]
    X = data[:,0:cols-1]
    y = data[:,cols-1:]
    return X, y
```

### Gradient descent函数
```python
import time
# data：带标签的training data
# theta: 跟特征一样维度的初始化的theta行向量
# batchSize：每次更新theta时用的数据个数，用来选择对应的3种梯度下降算法
#           bathchSize = X.shape[0] ：就是批量梯度下降
#           batchSize = 1 ：就是随机梯度下降
#           1 < batchSize < X.shape[0] ： 就是小批量梯度下降
def descent(data, theta, batchSize, stopType, thresh, alpha):
    
    init_time = time.time() # 用来计算梯度下降耗时
    i = 0 # 迭代次数
    k = 0 # batch
    X, y = shuffleData(data) 
    grad = np.zeros(theta.shape) # 计算的梯度（就是对各个theta[j]值的偏导数）
    costs = [cost(X, y, theta)] # 计算代价函数(先把训练前的第一个存进来)
    
    while True:
        grad = gradient(X[k:k+batchSize], y[k:k+batchSize], theta)
        k += batchSize 
        if k>= n:
            # 当跑满了循环次数后
            k = 0
            X, y = shuffleData(data) # 打乱数据
        theta = theta - alpha*grad # 参数更新
        costs.append(cost(X, y, theta)) # 计算新的代价函数
        i += 1
        
        if stopType == STOP_ITER:
            value = i
        elif stopType == STOP_COST:
            value = costs
        elif stopType == STOP_GRAD:
            value = grad
        if stopCriterion(stopType, value, thresh):
            break
    return theta, i-1, costs, grad, time.time() - init_time
```

# 测试方法
```python
def runExpe(data, theta, batchSize, stopType, thresh, alpha):
    theta, iter, costs, grad, dur = descent(data, theta, batchSize, stopType, thresh, alpha)
    #
    name = "Original" if(data[:,1]>2).sum() > 1 else "Scaled"
    #
    name += " data - learning rate:{} - ".format(alpha)
    #
    if batchSize == n:
        strDescType = "Gradient"
    elif batchSize == 1:
        strDescType = "Stochastic"
    else:
        strDescType = "Mini-batch({})".format(batchSize)
    name += strDescType + " descent - Stop: "
    #
    if stopType == STOP_ITER:
        strStop = "{} iterations".format(thresh)
    elif stopType == STOP_COST:
        strStop = "costs change < {}".format(thresh)
    else:
        strStop = "gradient norm < {}".format(thresh)
        
    name += strStop;
    print("***{}\nTheta: {} - Iter: {} - Last Cost: {:03.2f} - Duration: {:03.2f}s".format(
    name, theta, iter, costs[-1], dur))
    
    fig, ax = plt.subplots(figsize=(12,4))
    ax.plot(np.arange(len(costs)), costs, 'r')
    ax.set_xlabel('Iterations')
    ax.set_ylabel('Cost')
    ax.set_title(name.upper() + '- Error VS. Iteration')
    return theta
```

```python
n = X.shape[0]
runExpe(orig_data, theta, n, STOP_ITER, thresh=5000, alpha=0.000001)
```
![](https://lorwy.github.io/image/logistic_regression_test.png)
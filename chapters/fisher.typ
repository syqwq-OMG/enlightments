#import "../lib.typ": math-note
#import math-note: *
#import "../utils.typ": *
#import "@preview/mannot:0.3.1":*

#show: show-utils

== 关于 Fisher 信息量和乱七八糟的讨论

#let HH = $cal(H)$

考虑每个向量都是随机变量的无限维 Hilbert 空间 $HH$，则 
+ 估计量 $X$ 是 $HH$ 空间中的一个向量
+ 去中心化后， $X, Y$ 的内积就是协方差 $iprod(X,Y)=EE[X Y]=Cov(X, Y)$
+ 向量的范数就是标准差 $norm(X)=sqrt(EE[X^2]) approx sigma_(X)$

+ 若 $iprod(X,Y)=0$，则他们正交，也就是不相关

=== UMVUE 

一致最小方差无偏估计 (UMVUE) 的几何本质是：在给定的平面上寻找距离原点最近的点。

- 无偏估计的集合： 所有满足 $EE[hat(g)]=g(theta)$ 的估计量构成一个仿射子空间，记为 $cal(U)$

- 零无偏估计的集合：所有期望为 0 的估计量 $U$（即 $EE[U]=0$）构成了一个线性子空间，记为 $cal(Z)$。

于是， $cal(U)$ 其实就是对应的 $cal(Z)$ 平移了一个特定的向量。

为了在 $cal(U)$ 找一个 $hat(g)$ 使得他的方差也就是范数最小，根据几何的直觉，这等价与寻找一个与 $cal(U)$ 的方向正交的向量，而超平面的方向由他对应的 $cal(Z)$ 决定，因此我们有 

（这里只说明了中心化也就是 $EE[hat(g)]=0$ 的情况，但是平移后其实类似，因为 $EE[U]=0, forall U in cal(Z)$，且 $EE[X Y] = Cov(X,Y) + EE[X] EE[Y]$ ）

#theorem(title:[UMVUE 等价条件])[
  $hat(g)$ 是 UMVUE $<=>$ $forall U in cal(Z), iprod(hat(g), U)=Cov(hat(g), U) =0$.
]

=== Rao-Blackwell 定理

若 $T$ 是一个充分统计量，设子空间 $cal(S)_(T) $ 为所有 $h(T)$ 构成的闭子空间。 在之前提过，在 $L^(2) $ 中，条件期望 $EE[hat(theta) mid(|) T]$ 等价于 $hat(theta)$ 在 $cal(S)_(T)$ 上的正交投影。 

假设我们有一个无偏估计量 $hat(theta)$，由于 $cal(S)_(T) $ 是充分统计量 $T$ 的子空间，因此在 $cal(S)_(T) $ 上的投影 $hat(theta)^(*) = EE[hat(theta) mid(|) T]$ 也是统计量，也就是与 $theta$ 无关，从而我们得到了一个正交分解 $hat(theta) = hat(theta)^* + Z$， 根据勾股定理 
$
norm(hat(theta)^*)^(2)  <= norm(hat(theta)^*)^(2)  + norm(Z)^(2) = norm(hat(theta))^(2)
$

也就是：改进后的估计方差更小。

=== Fisher 信息量


Fisher 信息量衡量的是概率分布族 $f(x; theta)$ 这个曲面弯曲的程度，或者说 $theta$ 变化时，概率分布向量变化的快慢。

在这个空间中，每个点就是一个完整的概率密度函数 $f(x)$，因此当我们改变 $theta$ 时，我们就在这个函数空间中画出了一条曲线。在几何上，曲线 $gamma(theta)$ 的切向量我们定义为位置对于他参数的导数： 

$
V(x) = pdv(,theta) f(x;theta)
$

但是在统计学中，我们关心的是相对变化率。
试想，如果某一点概率密度 $f(x)$ 本来就是 0.00001，它增加了 0.00001，那是翻倍的剧变；但如果 $f(x)$ 本来是 100，增加 0.00001 则微不足道。所以，我们需要把绝对变化率标准化：

$
frac(pdv(f, theta), f, style:"skewed") = pdv(,theta) ln f(x; theta) := S(x; theta) 
$

这就是为什么 $S$ 被选为统计流形上切向量的代表。我们称为 Score function，它描述了对数似然空间中的切方向。

并且这个切向量时中心化的向量，也就是 
$
EE[S(X; theta)] = integral S(x; theta) f(x; theta) dd(x) = pdv(,theta) integral f(x; theta) dd(x) = pdv(,theta) 1 = 0
$

而 Fisher 信息量就是这个切向量的范数的平方：

$
I(theta) = norm(S)^(2) = EE[S(X; theta)^(2)] = Var(S(X; theta))
$

切向量越长，说明 $theta$ 稍微一动，分布变化就很剧烈，数据上反应的就剧烈，我们就越容易区分 $theta$，从而包含的信息量就越大。

=== Cramer-Rao 下界 
这是最精彩的部分。Cramér-Rao 下界本质上就是 Hilbert 空间中最基础的 Cauchy-Schwarz Inequality。

#theorem(title:[Cramér-Rao 下界])[
  设 $hat(g)$ 是参数 $theta$ 的无偏估计量，则他的方差满足不等式 
  $
  Var(hat(g)) >= frac([g'(theta)]^(2), I(theta))
  $
]
#let gh = $hat(g)$
我们的目标是找到估计量 $hat(g)$ 的方差下界。 因为 $hat(g)$ 是无偏的，从而
$
EE[gh (X)] = integral gh(x) f(x; theta) dd(x) = g(theta)
$

为了得到公式中的导数，我们对上式两边同时对 $theta$ 求导，得到

$
g'(theta) &= pdv(,theta) EE[gh(X)] = pdv(,theta) integral gh(x) f(x; theta) dd(x) \
&= integral gh(x) pdv(,theta) f(x; theta) dd(x) \
&= integral gh(x) f(x; theta) markhl(frac(1, f(x;theta)) pdv(,theta) f(x; theta)) dd(x) \
&= integral markhl(gh(x) S(x; theta), fill:#rgb("#d8dbfd")) f(x; theta) dd(x) = EE[gh(X) S(X; theta)]
$

于是，我们得到了 $EE[gh dot S] = iprod(gh, S)=g'(theta)$. 根据 Cauchy-Schwarz 不等式，我们有

$
norm(gh)^(2) dot norm(S)^(2) >= norm(iprod(gh, S))^(2)
$

- 由范数的定义： $norm(gh)^(2) = Var(hat(g))$
- 利用刚刚的结论： $iprod(gh, S) = g'(theta)$

- Fisher 信息量的定义： $norm(S)^(2) = I_n (theta)$

从而，我们得到了 
$
Var(hat(g)) dot I_n (theta) >= [g'(theta)]^(2)
$

上式中的总信息量 $I_n (theta)$，由于样本 $x_1, dots.h.c, x_n$ i.i.d.，所以 
$
S_n = sum S(x_i) => Var(S_n) = n dot Var(S) = n dot I(theta)
$

带入则证毕。

#line(stroke: luma(220), length: 100%)

更多内容可以去学习信息几何相关的知识，我觉得挺有意思的，但是还不会，可能之后有兴趣会去学习 Ciallo～(∠・ω< )⌒★
#import "../lib.typ": math-note
#import math-note: *
#import "../utils.typ": *
#show: show-utils

= 测度论与概率论

== 三大重要收敛定理

#theorem(title: [单调收敛定理(Monotone Convergence Theorem - MCT)])[
  若 $lr(( Omega, cal(F), mu ))$ 是一个测度空间， $lr({ f_i })_(i=1)^(oo)$ 是一族 $Omega -> RR$ 的可测函数，满足 $f_i arrow.t f$ a.e. 且 $integral f_1 dif mu > -oo$. 则积分和极限可以交换，且积分也单调收敛，即
  $
    integral f_i dif mu arrow.t integral f dif mu
  $
]

#remark(title: [热气球])[
  - 想象 $f_i$  是一个热气球在时刻 $i$  的体积， $integral f_i dif mu$  是它的总浮力。

  - 条件 $f_i arrow.t f$  意味着这个热气球只增不减，不断地膨胀，最终趋近于一个最终形态 f。

  - MCT定理说：既然热气球一直在稳定地、单调地变大，那么它浮力的极限，理所当然就是它最终形态的浮力。这个过程中没有“泄气”或者其他诡异的事情发生。
]

#proof[
  我们将证明分为两个主要部分：首先处理更简单也更基础的非负函数情况，然后利用它来证明一般情况。

  先假设 $f_1 >= 0$
  相当于证明等式：
  $
    lim_(n -> oo) integral f_n dif mu = integral f dif mu
  $
  考虑一边，即证明
  $ lim integral f_n dif mu <= integral f dif mu $ 这是显然的。 因为 $f_n arrow.t f$ 意味着 $forall n, f_n (omega)<= f(omega)$，从而 $integral f_n dif mu <= integral f dif mu$。因为 $integral f_n dif mu$ 单调有上界，因此 $lim integral f_n dif mu$ 存在，且 $lim integral f_n dif mu <= integral f dif mu$。

  接下来考虑另一侧
  $
    lim integral f_n dif mu >= integral f dif mu
  $
  回顾 $integral f dif mu$ 的定义是
  $
    integral f dif mu :=
    sup lr({ integral g dif mu mid(|) 0<=g<=f, g "为简单函数" })
  $
  如果我们可以证明对于任意的简单函数 $g$，都有 $c:=lim integral f_n dif mu >= integral g dif mu$，那么一定可以得到 $c$ 比他们的上确界大，从而得证。

  为此，任取简单函数 $g$ s.t. $0<= g<=f$，再取一个略小于 1 的数 $a:=1- epsilon$. 构造集合
  $
    E_n :=lr({ omega mid(|) f_n (omega) >= a g(omega) })
  $
  这个集合 $E_n$ 是指那些 $f_n$  的值已经“长得足够高”，至少达到了 $g$  的 $a$  倍的点 $omega$  的集合. 由于 $f_n$ 单调递增，因此这个集合也单调，即 $E_1 subset.eq E_2 subset.eq dots.h.c$. 因为 $f_n (omega) up f(omega)$ 且 $f(omega) >= g(omega)$，这个集合会不断扩大，直至整个 $g$ 的支撑集，也就是
  $
    union.big_(n=1)^(oo) E_n = lr({ omega mid(|) g(omega) > 0 })
  $
  从而，得到
  $
    integral f_n dif mu >= integral_(E_n) f_n dif mu
    >= a integral_(E_n) g dif mu
  $
  不等式两侧取极限得到
  $
    c >= a dot lim_(n -> oo) integral_(E_n) g dif mu = a dot integral g dif mu
  $
  因为 $g$ 是任取的，且 $a$ 可以任意接近 1，因此就有
  $
    c >= sup integral g dif mu = integral f dif mu
  $
  从而 $f_1$ 非负部分证完了。

  接下来，证明另一部分。

  我们构造函数列 $f_n ' = f_n - f_1$，则 $f_n ' >=0$ 且 $f_n ' up f':=f - f_1$，因此现在的 $f_n '$ 满足上面情况的所有条件，从而我们得到
  $
    integral f_n ' dif mu arrow.t integral f' dif mu <=>
    integral (f_n - f_1) dif mu arrow.t integral (f - f_1) dif mu
  $
  由于 $integral f_1 dif mu > -oo$ 利用积分的线性性，得到
  $
    integral f_n dif mu arrow.t integral f dif mu
  $
]

#theorem(title: [Fatou引理(Fatou's Lemma)])[
  若 $lr(( Omega, cal(F), mu ))$ 是一个测度空间， $lr({ f_i })_(i=1)^(oo)$ 是一族 $Omega -> RR$ 的*非负*可测函数. 则
  $
    integral liminf_(i -> oo) f_i dif mu <= liminf_(i -> oo) integral f_i dif mu
  $
]
#remark(title: [一个可能漏水的水桶])[

  - 想象 $integral f_i dif mu$  是一个桶在时刻 $i$  的总水量。 $f_i$  是水的分布。

  - $f_i$  不要求单调，你可以把水在桶里晃来晃去，甚至有些水会溅出来。

  - $liminf f_i$  是在晃动过程中，每个位置“最终”稳定留下的水位。

  - *Fatou 引理*说：最终桶里剩下的水量（左边），小于等于你每次测量水量的极限（右边）。

  - 为什么是不等式？因为在晃动的过程中（ $f_i$  不单调），可能有一部分“质量”（积分值）泄露掉了或“蒸发”了（数学上叫“跑到无穷远处”）。所以你最终看到的实体（ $liminf f_i$ ）的积分，可能会比积分的极限要小。
]
#proof[
  我们手里的工具是强大的*单调收敛定理(MCT)*，但它的使用条件很苛刻，要求函数序列是单调递增的。而 Fatou Í引理的 $lr({ f_i })$  序列不保证单调性。所以，证明的核心思想是：从不单调的 $lr({ f_i })$  出发，构造出一个相关的、新的、单调递增的序列 $lr({ g_j })$ ，然后对 $lr({ g_j })$  应用 MCT，最后再把结果和 $lr({ f_i })$  联系起来。

  我们先回顾 $liminf$ 的定义：
  $
    liminf_(i) f_i := sup_(j) inf_(i>=j) f_i
  $
  受到启发，我们定义新的函数列 $g_j$
  $
    g_j := inf lr({ f_i mid(|) i>=j})
  $
  也就是 $g_j$ 是原序列 $f_i$ 从第 $j$ 项开始的 “尾巴” 的下确界。由于所选取的集合越来越小，因此下确界是递增的，从而有 $g_1<=g_2<=dots.h.c$，这就意味着我们构造出了一个单调递增的序列。

  而根据 $liminf$ 的定义，这个单调递增序列 $lr({ g_j })$  的极限（也就是它的上确界 $sup g_j$ ）正好就是 $liminf f_i$ 。所以我们有：$g_j up liminf f_i$ 。因为 $f_i$ 都非负，所以 $g_j$ 也非负。应用 MCT，我们得到
  $
    lim_(j -> oo) integral g_j dif mu = integral liminf_(i -> oo) f_i dif mu
  $
  而这就是我们要证明的不等式的左边，接下来我们考虑右边。

  由于 $g_j$ 的定义 $g_j=inf lr({ f_i mid(|) i>=j })$，于是 $forall i>=j, f_i >= g_j$，利用积分的单调性有
  $
    forall i>=j, integral f_i dif mu >= integral g_j dif mu
  $
  既然 $integral g_j dif mu$ 比这里的每一项都要小，那么一定小于等于他们的下确界，从而有关键不等式
  $
    integral g_j dif mu <= inf_(i>=j) integral f_i dif mu
  $
  我们对上面这个不等式两边同时取 $j to oo$  的下极限 $liminf$
  $
    lim_(j to oo) integral g_j dif mu = liminf_(j to oo) integral g_j dif mu <=
    liminf_(j to oo) lr(( inf_(i>=j) integral f_i dif mu ))
  $
  由于 $g_j$ 是单调收敛的序列，因此下极限等于极限等于 $integral liminf_(i to oo) f_i dif mu$. 在这个不等式的右边，被取极限的部分正好符合 $liminf$ 的定义，因此就等于 $liminf integral f_j dif mu$，把两侧的分析结果带入，就得到了我们要证明的 Fatou 引理
  $
    integral liminf_(i -> oo) f_i dif mu <= liminf_(i -> oo) integral f_i dif mu
  $
]

#theorem(title: [控制收敛定理 (Dominated Convergence Theorem - DCT)])[
  若 $lr(( Omega, cal(F), mu ))$ 是一个测度空间， $lr({ f_i })_(i=1)^(oo)$ 是一族 $Omega -> RR$ 的可测函数， $g$ 是一个可积函数。 如果 $lr(| f_i |)<=g$ a.e. 且 $forall omega in Omega, f_i (omega) to f(omega)$ (逐点收敛)，则 $f$ 也是可积的，且积分和极限可交换，即
  $
    integral f_i dif mu to integral f dif mu <=> integral f dif mu = integral lim_(n -> oo) f_n dif mu = lim_(n -> oo) integral f_n dif mu
  $
]

#remark(title: [有盖子的桶])[
  - 这就像 *Fatou 引理*里那个可能漏水的桶，但现在我们给它加了一个坚固的盖子 ($g$)。

  - $f_i to f$  意味着桶里的水最终会形成一个稳定的形态 $f$ 。

  - $lr(| f_i |)<=g$  且 $integral g dif mu<oo$  这个“盖子”的作用是阻止任何水的泄露和蒸发。因为所有的水都被限制在一个总容量有限的空间里。

  - *DCT 定理*说：既然一滴水都没有损失，那么水量的极限，自然就等于极限形态下水的总量。
]
#proof[
  证明的核心思想是构造两条“单调的夹板”来挤压
  原始的序列 $lr({ f_i })$  本身不一定是单调的，所以我们不能直接用 MCT。因此，我们从 $lr({ f_i })$  出发，构造出两个新的、单调的函数序列，一个从下方逼近 $f$ ，一个从上方逼近 $f$ ，像两块夹板一样把 $f_i$  夹在中间。然后我们分别对这两条“单调的夹板”应用 MCT。

  我们定义两个辅助序列：
  1. 地板序列 $f_i^(and)$
    $
      f_i^(and) := inf lr({ f_j mid(|) j>=i })
    $
    这个序列是单调递增的，并且收敛到 $liminf f_i$。 因为 $f_i to f$，所以 $f_i^(and) up f$.
  2. 天花板序列 $f_i^(or)$
    $
      f_i^(or) := sup lr({ f_j mid(|) j>=i })
    $
    这个序列是单调递减的，并且收敛到 $limsup f_i$。 因为 $f_i to f$，所以 $f_i^(or) down f$.

  通过定义，我们得到
  #math.equation(
    $
      f_i^(and) <= f_i <= f_i^(or)
    $,
  )<eq-sandwitch>

  由于 $g$ 的存在保证了有限且可积，因此对于地板序列应用 MCT，我们得到
  $
    lim_(i -> oo) integral f_i^(and) dif mu = integral f dif mu
  $
  类似的，应用 MCT（递减版），我们得到
  $
    lim_(i -> oo) integral f_i^(or) dif mu = integral f dif mu
  $
  对 @eq-sandwitch 取积分，得到
  $
    integral f_i^(and) dif mu <= integral f_i dif mu <= integral f_i^(or) dif mu
  $
  再通过取极限，应用夹逼定理得到
  $
    lim_(i -> oo) integral f_i dif mu = integral f dif mu
  $
]

// #counter(page).update(0)
// #pagebreak()

== 为什么要有概率密度函数？

为了接下来的讨论，我们首先要在一些概念的定义上达成共识。
#definition(title: [可测函数])[
  对于两个可测空间 $(Omega,cal(F)),(S,cal(S))$，如果存在一个函数 $X:Omega to S$ 满足
  $
    X^(-1)(B) := lr({ omega mid(|) X(omega) in B }) in cal(F), forall B in cal(S)
  $
  那么，称 $X$ 是一个从 $(Omega,cal(F))$ 到 $(S,cal(S))$ 的*可测函数*。
]<def-mf>

#remark[这说的就是对于任何一个事件 $omega in cal(F)$，我们固然可以得知他的结果 $X(omega)$，而可测函数的定义是在说，我任意给定一个 $B in cal(S)$，他一定有 $cal(F)$ 中的可测事件与他对应。]

#definition(title: [随机向量、随机变量])[
  在 @def-mf 中，如果 $(S,cal(S))=(RR^(d), cal(R)^(d) )$，当 $d>1$ 时，我们称 $X$ 为*随机向量*；当 $d=1$ 时，我们称 $X$ 为*随机变量*。
]

我们为了研究一个事件发生的概率，例如抛出一枚硬币是否是正面朝上，一个很直观的想法就是把所有可能的情况列出来，而随机变量的作用就是给某些情况的集合一个“标签”，就如同拎葡萄，抓着柄就抓了一串，并且随机变量的定义也保证了这样拎出来的集合一定也是可测的。这样就可以让我们在讨论某些具有共性的集合的时候更加得心应手。

在抛硬币中，我们假设 $X$ 是一个随机变量，它的取值为 $0$（反面）或 $1$（正面）。
那么，我们可以很清晰地通过*分布列（PMF）*来研究整个样本空间中每个事件发生的概率：

#align(
  center,
  (
    symbol-table(r: 2, c: 3)(
      [],
      $X=0$,
      $X=1$,
      $P$,
      $1\/2$,
      $1\/2$,
    )
  ),
)

但是，当问题来到连续型随机变量时，这就并不奏效了。

考虑这样一个场景，我们有一个理想的随机数生成器，会随机地、均匀地从 $[0,1]$ 中生成一个数字 $X$. 现在，让我们尝试用分布列的逻辑来描述它。这意味着我们要给 $[0, 1]$ 区间内的每一个点都赋予一个概率值 $P(X=x)$.
那么此时，灾难性的问题出现了：
- 区间内有多少点？无穷个。
- 我们应该给每个 $P(X=x)$ 赋予多大的值？
  - 假设我们给每个点的概率是一个很小的 $epsilon>0$，那么总概率
    $ sum_(x in [0,1])P(X=x)= sum_(x in [0,1]) epsilon = oo times epsilon = oo $一发不可收拾了 #emoji.face.cry
  - 既然不能是正数，那么只能是0了。但是
    $ sum_(x in [0,1])P(X=x)= sum_(x in [0,1]) 0 = 0 $这与 $P(Omega)=1$ 的要求不符，也不对啊 #emoji.face.cry

分布列这个工具，它的“给每个点分配一块概率，然后加总”的核心思想，在面对连续变量的“不可数无穷”特性时，彻底失效了。无论怎么给单点分配概率，总概率要么是无穷，要么是0，永远凑不成那个必需的“1”。

既然纠结于单点的概率是死路一条，于是我们换一个角度：能不能不讨论单点的概率，而是讨论一个区间的概率？
这个思想的转变，就是引入PDF的直觉来源。
#v(0.5em)
+ *放弃“点的质量”，拥抱“点的密度”*

  想象一根一米长的金属棒，总质量是1千克。
  你问：“在0.5米那个点上，质量是多少？” 答案是0。一个没有长度的点，自然没有质量。
  但是，你可以问：“在0.5米那个点附近，质量的密度是多少？” 这就有意义了，比如是 1.2 公斤/米。

  *密度这个概念，描述的不是一个点的质量，而是这个点周围质量的集中程度。*
+ *PDF 就是概率上的密度*

  概率密度函数 (PDF) $f(x)$ 就扮演了这个“密度”的角色。
  $f(x)$ 本身的值不是概率，就像 “kg/m#super("3")” 不是 “kg” 一样。
  *$f(x)$ 的值越大，表示随机变量落在 $x$ 附近的可能性就越“密集”或越“集中”。*

+ *如何从“密度”得到“概率”？*

  对于那根金属棒，如何从密度得到一段区间的质量？答案是积分！把从0.4米到0.6米的密度函数积分，就得到了这段的质量。
  $
    m=integral_(L) lambda dif ell
  $

  同理，对于连续型随机变量，要计算它落在区间 $[a, b]$ 内的概率，我们就需要对概率密度函数在这个区间上进行积分：
  $
    P(a <= X <= b) = integral_(a)^(b) f(x) dif x
  $
  这个模型完美解决了以前的所有问题：总概率 $integral_(-oo)^(oo) f(x) dif x=1$ ，而单点的概率 $P(X=a)=integral_(a)^(a) f(x) dif x=0$。所有矛盾都消失了。

因此，我们就引出了如下的定义。
#definition(title: [连续型随机变量])[
  在概率空间 $(Omega,cal(F),P)$ 上，如果随机变量 $X:Omega to RR$ 满足：

  存在一个可测函数 $f:RR to [0,oo)$ 使得
  $
    P(X <= x) = integral_(-oo)^(x) f(t) dif t, -oo < x< oo
  $
  那么称 $X$ 为*连续型随机变量*，$f$ 为其*概率密度函数（PDF）*。
]

但是，这里有一个小问题：我们之前的讨论都是对于区间 $[a,b]$ 的概率，而定义中却是 $(-oo,x]$ 的概率，这是否合理呢？答案是肯定的。事实上，由所有形如 $(−oo,x]$ 的半无限区间构成的集合，是整个实数轴上 Borel 代数 $cal(B)(RR)$  的一个*生成元*，也就是通过可数次交并补操作得到整个 $cal(B)(RR)$. 而对于具有这样性质的集合，我们有一个很神奇的定理

#theorem(title: [Carathéodory 扩张定理])[
  设 $cal(A)$ 是集合 $X$ 上的代数， $mu_0$ 是集合 $cal(A)$ 上的一个预测度。令 $mu^\*$ 是由 $mu_0$ 导出的外测度。那么所有 $mu^\*$-可测集构成的集合 $cal(M)$ 满足：
  + $cal(M)$ 是一个 $sigma$-代数
  + $cal(A)subset.eq cal(M)$
  + 这个测度 $mu$  是预测度 $mu_0$ 的一个扩张，即对于任何在原始代数中的集合 $A in cal(A)$，都有 $μ(A)=μ_0(A)$。

  如果在上述条件下，预测度 $mu_0$ 是 $sigma$-有限的（即存在一系列 $A_i in cal(A)$ s.t. $union.big_(i=1)^(oo) A_i=X$ 且 $mu_0(A_i)<oo$），那么这个扩张是唯一的。
]<thm-ext>

既然所有我们关心的区间（以及更复杂的集合）都可以由 $(−oo,x]$ 这种“基本砖块”通过集合运算搭建而成，那么根据 @thm-ext 中测度的唯一性，我们可以得出一个结论：

#mark[只要我们在“生成元”这个集合上定义好了概率，那么所有由它生成的更复杂的集合（所有 Borel 集）上的概率也就被唯一地确定了。]

#line(stroke: (paint: luma(190), thickness: 1pt, dash: "densely-dashed"), length: 100%)


感谢大家的补充解释，以下是我基于个人理解的一些整理。 #qwq

同样从金属棒入手，想象一根一米长的密度不均匀的金属棒。我们现在有两种测度：
+ 质量测度 $mu$：这是一个函数，你给它棒上的任意一段区间 $A$ ，它会返回这段区间的质量 $mu(A)$
+ 长度测度 $lambda$：这是一个函数，你给它任意一段区间 $A$ ，它会返回这段区间的长度 $lambda(A)$ 。这本质上就是勒贝格测度。

这根棒的总质量 $mu([0,1])$  是 1千克。但由于密度不均，我们不能简单地说“质量等于长度”。那么，我们如何描述在*每一个点 $x$  上，质量相对于长度的“集中程度”*呢？

对于这种问题，我们考虑“求导”的思想。在微积分中， $dif y \/ dif x$ 描述了 $y$ 相对于 $x$ 的变化率。
类似的，我们想定义一个 “测度对于测度的导数” $dif mu \/ dif lambda$。这个导数是一个函数，我们称为密度函数 $rho(x)$，他在某个点 $x$ 的值，代表了该点单位长度上所拥有的质量。

那么怎么求这个值？我们可以想象在点 $x$  附近取一个极小的区间 $Delta A$ ，然后计算这个区间的质量与长度之比： $mu(Delta A) \/ lambda(Delta A)$。当这个小区间缩向点 $x$ 时，这个比值的极限就是点 $x$ 的密度 $rho(x)$。
一旦我们求出了这个密度函数 $rho(x)$ （也就是那个“导数”），我们就可以通过积分来反求任何一段区间的总质量：
$
  mu(A)=integral_(A) rho(x) dif lambda(x)
$
这个过程，就是从导数（密度）通过积分还原原函数（质量）的过程。

那么，接下来问题回到概率论中。现在我们也有两种测度：
+ 概率测度 $P_X$：这是由随机变量 $X$ 导出的测度。你给它实数轴上任意一个事件（Borel 集） $A$ ，它返回 $X$ 落入 $A$ 的概率 $P_X(A)$ 。这对应了上面例子中的“质量测度 $mu$”。
+ 勒贝格测度 $lambda$：这是实数轴上标准的“长度”测度。

在进行求导之前，必须满足一个关键条件，就是测度的绝对连续性 (Absolute Continuity)。

#definition(title: [测度的绝对连续性])[
  如果 $mu,nu$ 是同一个测度空间上的两个测度，那么我们称 $mu$ 相对于 $nu$ 是*绝对连续的*，如果对于任何集合 $A$ ，只要 $nu(A)=0$，那么 $mu(A)=0$，记为 $mu << nu$。形式化地说就是
  $
    mu << nu <=> (nu(A)=0 => mu(A)=0)
  $
]

在这里，我们说概率测度 $P_X$ 相对于勒贝格测度 $lambda$ 是绝对连续的，如果对于任何集合 $A$ ，只要它的“长度”为零 $lambda(A)=0$，那么它的“概率”也必须为零 $P_X (A)=0$，#mark[显然单点集就是这样的零测集]。


#remark(title: [绝对连续性])[
  直观含义就是“没有长度的地方，就没有概率”。这意味着概率不会“凭空”集中在一些没有长度的“点”或“尘埃”上。这完美地排除了离散概率（集中在单点上），并从根本上解释了为什么连续随机变量在单点的概率为0。
]

#theorem(title: [拉东-尼科迪姆定理 (The Radon-Nikodym Theorem)])[
  如果测度空间 $(X,Σ)$ 上的一个 $sigma$-有限测度 $nu$ 关于另一个 $sigma$-有限测度 $mu$ 绝对连续，那么存在一个在 $X$ 上的非负可测函数 $f:X to [0,oo)$，也就是 $mu$ 关于 $nu$ 的密度，或者 Radon-Nikodym 导数 $f=dv(mu, nu, s: slash)$. 对所有的可测集合 $A$ ，都有：
  $
    mu(A)=integral_(A) f dif nu
  $
]

那么在概率论的语境下，如果概率测度 $P_(X)$ 相对于勒贝格测度 $lambda$ 是绝对连续的，那么根据拉东-尼科迪姆定理，必然存在一个唯一的（几乎处处唯一）非负可积函数 $f_X$ ，使得对于任何事件 $A$ ，都有：
$
  P_X (A)=integral_(A) f_X (x) dif lambda(x)
$


这个必然存在的函数 $f_X$ 就是 $P_X$ 相对于 $lambda$ 的 Radon-Nikodym导数，我们给这个函数起了一个专门的名字：*概率密度函数 (PDF)*。

== 2025-10-11 概率论作业
#problem[
  设 $X$ 为仅取非负整数的离散随机变量，若其数学期望存在，证明：
  + $E(X)=sum_(k=1)^(oo) P(X >= k)$

  + $sum_(k=0)^(oo) k P(X>k)=frac(1, 2) lr(( E(X^(2))-E(X) ))$
]
#proof[
  + 不难发现，这是由于无穷级数收敛，从而求和可以交换次序。

  + 同理，由于无穷级数求和收敛，根据等差数列求和公式易证。
]

#problem[
  甲、乙、丙三人进行比赛，规定每局两个人比赛，胜者与第三人比赛，依次循环，直至有一人连胜两次为止，此人即为冠军.而每次比赛双方取胜的概率都是1/2，现假定甲、乙两人先比，试求各人得冠军的概率.
]
#solution[
  假设 $(X,Y)$ 表示在上一场比赛中， $X$ 战胜了 $Y$. 记甲,乙,丙分别为 $A,B,C$. 那么比赛的可能状态有 $(A,B),(B,A),(A,C),(C,A),(B,C),(C,B)$. 记 $P_(A) (X,Y)$ 为在状态 $(X,Y)$ 下， $A$ 最终获得冠军的概率. 那么，由于初始条件，我们得到
  $
    P(A)=frac(1, 2)lr((P_(A)(A,B)+P_(A)(B,A)))
  $
  接下来，考虑各个状态下的转移概率：
  + $(A,B)$ 下，如果 $A$ 获胜了，那么直接赢得比赛；如果 $A$ 战败了，那么进入 $(C,A)$ 状态。因此
    $
      P_(A)(A,B)=frac(1, 2)lr((1+P_(A)(C,A)))
    $
  + $(B,A)$ 下，如果 $B$ 获胜了， $B$ 直接赢了，此时 $A$ 获胜的概率为0；如果 $B$ 战败了，那么进入 $(C,B)$ 状态。因此
    $
      P_(A)(B,A)=frac(1, 2)lr((0+P_(A)(C,B)))
    $
  + $(A,C)$ 下，如果 $A$ 赢了，那么 $A$ 直接获胜；如果 $A$ 输了，那么进入 $(B,A)$ 状态。因此
    $
      P_(A)(A,C)=frac(1, 2)lr((1+P_(A)(B,A)))
    $
  + $(C,A)$ 下，如果 $C$ 赢了，那么 $C$ 直接获胜，此时 $A$ 获胜的概率为0；如果 $C$ 输了，那么进入 $(B,C)$ 状态。因此
    $ P_(A)(C,A)=frac(1, 2)lr((0+P_(A)(B,C))) $
  + $(B,C)$ 下，如果 $B$ 赢了，那么 $B$ 直接获胜了，此时 $A$ 获胜的概率为0；如果 $B$ 输了，那么进入 $(A,B)$ 状态。因此
    $
      P_(A)(B,C)=frac(1, 2)lr((0+P_(A)(A,B)))
    $
  + $(C,B)$ 下，如果 $C$ 赢了，那么 $C$ 直接获胜了，此时 $A$ 获胜的概率为0；如果 $C$ 输了，那么进入 $(A,C)$ 状态。因此
    $
      P_(A)(C,B)=frac(1, 2)lr((0+P_(A)(A,C)))
    $
  
  联立以上的6个方程，得到
  $
  P_(A) (A,B) = frac(4, 7) \ P_(A) (B,A)=frac(1, 7) 
  $ 
  因此得到 
  $
  P(A)=frac(1, 2)(P_(A)(A,B)+P_(A)(B,A)) = frac(5, 14)
  $ 
]

---
html header: <script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
---

# Computer Vision Project

이 프로젝트는 Camera Calibration과 Disparity Map, Depth Map을 생성하는 프로젝트이다.

## Camera Calibration

먼저, 체커보드를 이용해서 Camera Calibration을 수행한다. 6개의 체커보드 이미지가 있고, 모서리를 찾아서 이를 평면좌표(world point)로 만들어주는 homography matrix를 찾고, 그 matrix에서 intrinsic, extrinsic 파라미터를 찾는 과정이다. [Zhang's method](http://staff.fh-hagenberg.at/burger/publications/reports/2016Calibration/Burger-CameraCalibration-20160516.pdf)를 사용하여 수행할 수 있다.

### Homography Calculation

먼저 $s\tilde{q}=H\tilde{p}$를 만족하는 행렬 $H$를 찾아야 한다. ($\tilde{q}$는 world point, $\tilde{p}$는 체커보드 좌표)

$$H = \left[\begin{matrix}h_{11} & h_{12} & h_{13}\\ h_{21} & h_{22} & h_{23} \\ h_{31} & h_{32} & h_{33}\end{matrix}\right]$$

으로 표현되고, $\min_H\sum_{j=1}^m\left|\left|q_j-\hat{q_j}\right|\right|^2$를 최소화하는 $H$를 찾으면 된다.
($q_j = \left[\begin{matrix}u_j \\ v_j\end{matrix}\right]$, $\hat{q_j} = \frac{1}{h_{31}X_j+h_{32}Y_j+h_{33}}\left[\begin{matrix}h_{11}X_j+h_{12}Y_j+h_3\\h_{21}X_j+h_{22}Y_j+h_{23}\end{matrix}\right]$)

이를 정리하면,

$$\min_H\sum_j\left|\left|\left[\begin{matrix}u_0(h_{31}X_j+h_{32}Y_j+h_{33})-(h_{11}X_j+h_{12}Y_j+h_{13})\\v_0(h_{31}X_j+h_{32}Y_j+h_{33})-(h_{21}X_j+h_{22}Y_j+h_{23})\end{matrix}\right]\right|\right|^2$$

이 되는데, 각 항을 풀어보면

$$\left[\begin{matrix}-X_j & -Y_j & -1 & 0 & 0 & 0 & u_jX_j & u_jY_j & u_j \\  0 & 0 & 0 & -X_j & -Y_j & -1 & v_jX_j & v_jY_j & v_j\end{matrix}\right]
\left[\begin{matrix}h_{11}\\ h_{12} \\h_{13} \\h_{21} \\h_{22} \\h_{23} \\h_{31} \\h_{32} \\h_{33}\end{matrix}\right]$$

이라고 쓸 수 있다. 앞에 곱해진 행렬을 $L_j$라고 하면 이 문제는 $\min_x||Lx||^2$문제가 된다. ($L$은 $L_j$를 세로로 늘어뜨린 행렬) 따라서 $L^TL$의 가장 작은 eigenvalue중 가장 작은 것에 대응하는 eigenvector를 찾으면 된다.

### Intrinsic Parameter



### Extrinsic Parameter

## Depth Map

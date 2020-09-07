author: Ir1d, HeRaNO, Chrogeek, abc1763613206

## Polar coordinates and polar coordinate system

> This paragraph is taken from chapter 4-4 high school mathematics electives, people's education edition.

Let's consider the actual scenario, such as sailing. We say "$B$ is in the direction of $30^\circ$ north east of $A$ , and the distance is $100$ meters" instead of "using $A$ as the origin to create a rectangular coordinate system, $B(50,50\sqrt 3)$ ".

In this way, we choose a certain point $O$ on the plane, called **pole**, and draw a ray $Ox$ from the pole, called **polar axis**. Then choose a unit length (usually in mathematical problems it is $1$ ), an angle unit (usually radians), and its positive direction (usually counterclockwise), thus a **polar coordinate system** is established.

How do we describe the position in the polar coordinate system?

Let $A$ be a point on the plane, and the distance $|OA|$ , denoted as $\rho$, between the pole $O$ and $A$ is the **polar diameter**, taking the $\angle xOA$ , denoted as $\theta$ , starting from the polar axis, and ending at the edge $ OA$ as **polar angle**, then the ordinal pair $(\rho,\theta)$ is the **polar coordinate of $A$**.

According to the definition of the same angle at the end, the point represented by $(\rho,\theta)$ and $(\rho,\theta+2k\pi)\ (k\in \mathbb{Z})$ is actually the same. In particular, the polar coordinate of the pole is $(0,\theta)\ (\theta\in \mathbb{R})$, so there are countless kinds of polar coordinates of points in the plane.

If $\rho>0,0\le \theta<2\pi$ is specified, then in addition to the poles, points in other planes can be represented by a unique ordinal pair $(\rho,\theta)$ , and points represented by polar coordinate $(\rho,\theta)$ is uniquely determined.

Of course, sometimes it is not very convenient to study the graphics in the polar coordinate system. If we want to study it in the rectangular coordinate system, we can use the mutualization formula.

The rectangular coordinates $(x,y)$ of the point $A(\rho,\theta)$ can be expressed as follows:

$$
\begin{cases}
x=\rho \cos \theta\\
y=\rho \sin \theta
\end{cases}
$$

Then we will know that:

$$
\rho ^2=x^2+y^2\\
\tan \theta=\frac{y}{x}\ \ \ \ (x\not =0)
$$

Therefore, the polar angle $\theta=\arctan \frac{y}{x}$ , so that the polar angle can be obtained.

In programming, if the arctangent function is required, try to use `atan2(y, x)`, which is more versatile than `atan(x)`.
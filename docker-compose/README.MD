# Jumpserver 

Jumpserver 是一款开源的堡垒机，部署起来稍微有点繁琐。

虽然官方发布了一个 Docker 镜像以完成快速部署，不过却是一个 All in one Docker，该镜像集成了所需要的组件，支持使用外置 Database 和 Redis。其官方不建议在生产环境中使用, 因为所有软件都打包到一个 Docker 中了,不是 Docker 最佳实践。

确实没错，All in one Docker 确实不是 Docker 的最佳实践，但是参考其分布式部署文档，可以看到 Jumpserver 是构建了各个组件的 Docker 镜像的，这些组件是基于 CentOS 构建的镜像。

考虑到容器应该尽可能的减少体积，我参考了官方的相关资料构建了基于 Alpine 的 Jumpserver 核心组件镜像，它符合 Docker 的最佳实践，可以实现分布式部署。

# 使用官方Python镜像作为基础镜像
FROM python:3.9-slim

# 设置工作目录
WORKDIR /app

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    gcc \
    libmariadb-dev \
    pkg-config \
    netcat-openbsd \
    tzdata \
    && rm -rf /var/lib/apt/lists/*

# 复制wait-for-it.sh脚本到容器中
COPY wait-for-it.sh /app/wait-for-it.sh
RUN chmod +x /app/wait-for-it.sh


# 仅复制requirements.txt文件到容器中
COPY requirements.txt .

# 安装Python依赖
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# 复制应用程序代码到容器中
COPY . /app

# 暴露gradio运行的端口
EXPOSE 7860

# 运行应用程序
CMD ["python", "web_demo.py"]

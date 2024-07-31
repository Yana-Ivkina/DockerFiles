FROM ubuntu:18.04

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        software-properties-common \
    && add-apt-repository -y ppa:deadsnakes \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        python3.8-venv \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
         && apt-get update \
         && DEBIAN_FRONTEND=noninteractive apt-get install -y python3-venv

RUN python3.8 -m venv /venv
ENV PATH=/venv/bin:$PATH

RUN pip3 install pytest

RUN apt-get update \
       && DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-11-jdk \
       && apt install -y wget \
       && wget https://github.com/allure-framework/allure2/releases/latest/download/allure-2.30.0.tgz \
       && tar -xvzf allure-2.30.0.tgz -C /opt/
       

RUN ln -s /opt/allure-2.30.0/bin/allure /usr/bin/allure
ENV PATH=/opt/allure-2.30.0/bin:$PATH

CMD ["/bin/bash"]
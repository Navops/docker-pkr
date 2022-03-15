FROM python:3.9

RUN git clone https://github.com/altairengineering/pkr.git && \
    mkdir /wheels && cd /pkr && \
    XDG_CACHE_HOME=/wheels pip wheel .


FROM python:3.9-slim

COPY --from=0 /wheels /wheels

RUN XDG_CACHE_HOME=/wheels pip install pkr
RUN apt-get update && apt-get install --no-install-recommends -y \
    git \
    && rm -rf /var/lib/apt/lists/*

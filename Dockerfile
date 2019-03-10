FROM continuumio/anaconda3

ADD . /code
WORKDIR /code

RUN pip install git+https://github.com/inconvergent/fn

RUN pip install -r requirements.txt

# install cairocffi since pycairo doesn't work
RUN pip install cairocffi

RUN apt-get update
RUN apt-get install gcc -y --fix-missing

# Need gcc before installing fast-sand-paint & twisted
RUN pip install git+https://github.com/inconvergent/fast-sand-paint
RUN pip install twisted==18.9.0
RUN pip install git+https://github.com/inconvergent/zonemap

# hack to use cairocffi instead of cairo
#RUN sed -i "s|from cairo |from cairocffi |g" ../opt/conda/lib/python3.7/site-packages/iutils/render/render.py
#RUN sed -i "s|import cairo |import cairocffi |g" ../opt/conda/lib/python3.7/site-packages/iutils/render/render.py

# RUN python3 ./setup.py build_ext --inplace

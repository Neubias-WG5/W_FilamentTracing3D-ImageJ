FROM neubiaswg5/fiji-base

RUN pip install git+https://github.com/jni/skan
ADD IJFilamentTracing3D.ijm /fiji/macros/macro.ijm

ADD wrapper.py /app/wrapper.py

ENTRYPOINT ["python", "/app/wrapper.py"]



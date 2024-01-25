FROM python

WORKDIR /usr/src/lorasim

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD [ "python", "loraDir.py", "12", "1000", "0", "15000", "0"]
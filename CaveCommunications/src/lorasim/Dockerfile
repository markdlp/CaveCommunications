FROM python as compiler
ENV PYTHONUNBUFFERED 1

WORKDIR /usr/src/lorasim

RUN python -m venv /opt/venv
# Enable venv
ENV PATH="/opt/venv/bin:$PATH"

COPY requirements.txt /usr/src/lorasim/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt


FROM python as runner
WORKDIR /usr/src/lorasim
COPY --from=compiler /opt/venv /opt/venv

# Enable venv
ENV PATH="/opt/venv/bin:$PATH"

COPY . .

CMD [ "python", "loraDir.py", "12", "1000", "0", "15000", "0"]
FROM docker:24.0.6
LABEL maintainer="RafikFarhad <rafikfarhad@gmail.com>"

RUN apk update && \
    apk upgrade && \
    apk add --no-cache git curl python3 bash

#  Downloading gcloud package and install
RUN mkdir -p /usr/local/gcloud \
  && curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz | tar xvzf - -C  /usr/local/gcloud \
  && /usr/local/gcloud/google-cloud-sdk/install.sh \
  && /usr/local/gcloud/google-cloud-sdk/bin/gcloud components remove bq gsutil \
  && rm -rf /usr/local/gcloud/google-cloud-sdk/.install/.backup

# Adding the package path to local
ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin

ADD entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

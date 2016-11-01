FROM continuumio/miniconda

RUN apt-get update --fix-missing && apt-get install -y gcc libatlas-dev \
    liblapack-dev gfortran graphviz texlive-latex-extra dvipng && apt-get clean

RUN mv /bin/sh /bin/sh_old; ln -s /bin/bash /bin/ssh

# Create an env with all these packages so we can use the cache later.
RUN conda create -n cache Cython jinja2 scipy matplotlib requests beautifulsoup4 sqlalchemy scikit-image pytest wcsaxes pyyaml pandas nomkl pytest-cov coverage

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "/bin/bash" ]

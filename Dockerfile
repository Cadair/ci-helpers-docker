FROM continuumio/miniconda

RUN apt-get update --fix-missing && apt-get install -y gcc libatlas-dev \
    liblapack-dev gfortran graphviz texlive-latex-extra dvipng && apt-get clean

RUN ln -s /opt/conda /root/miniconda

# Create an env with all these packages so we can use the cache later.
RUN conda create -n cache Cython jinja2 scipy matplotlib requests beautifulsoup4 sqlalchemy scikit-image pytest pyyaml pandas nomkl pytest-cov coverage
# Create the same cache with conda-forge packages
RUN conda create -c conda-forge -n cache2 Cython jinja2 scipy matplotlib requests beautifulsoup4 sqlalchemy scikit-image pytest pyyaml pandas nomkl pytest-cov coverage

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "/bin/bash" ]

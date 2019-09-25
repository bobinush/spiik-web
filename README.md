# spiik-web

### HOWTO ändra något som inte går via CMS:et
https://doc.locomotivecms.com/docs

1. Installera Ruby https://gorails.com/setup/ 
Du behöver inte Rails, Git, SQL osv..

2. Installera Wagon http://doc.locomotivecms.com/

3. Gå till fliken "Developers" på SPIIK's CMS och följ instruktionerna.
(OBS det är två olika för vanliga hemsidan och nollningssidan)

### Den enkla vägen: 
1. Installera Docker
2. Bygg Docker image
`docker build -t spiikcom .`
3. Kör `docker run -ti --privileged -v SÖKVÄG_TILL_DELAT_MAPP:/spiik -p 127.0.0.1:3333:3333 spiikcom`  
Om du i framtiden får felet "#<Errno::EADDRNOTAVAIL: Failed to open TCP connection to localhost:35729..." kör då detta kommando: [(Källa)](https://github.com/locomotivecms/wagon/issues/340)

    ```sh
    cp /etc/hosts /etc/hosts.new && \
    sed -i 's/::1\tlocalhost ip6-localhost ip6-loopback/::1 ip6-localhost ip6-loopback/' /etc/hosts.new && \
    cp -f /etc/hosts.new /etc/hosts
    ```

4. För att klona hemsidan, gå till fliken "Developers" på SPIIK's CMS och följ instruktionerna.

5. Du kan nu nå sidan lokalt via http://localhost:3333/

6. Tyvärr måste du köra `bundle install` efter varje gång du "loggat ut" från dockern.. Det är en todo..

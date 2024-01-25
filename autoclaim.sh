email="$1"
password="$2"


haha="$(curl -sL -D - "https://freenet.cafe/login" | sed -nE 's/.*XSRF-TOKEN=([^;]*)\;.*/XSRF-TOKEN=\1/p;s/.*fcafessh_session=([^;]*)\;.*/fcafessh_session=\1/p;s/.*_token" value="([^"]*)".*/_token=\1/p')"
hehe="$(curl -D- 'https://freenet.cafe/authenticate' \
  -H 'authority: freenet.cafe' \
  -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7' \
  -H 'accept-language: en-GB,en;q=0.9,ja-JP;q=0.8,ja;q=0.7,en-US;q=0.6' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/x-www-form-urlencoded' \
  -H "cookie: XSRF-$(sed -n 1p <<< "$haha"); $(sed -n 2p <<< "$haha")" \
  -H 'origin: https://freenet.cafe' \
  -H 'pragma: no-cache' \
  -H 'referer: https://freenet.cafe/login' \
  -H 'sec-ch-ua: "Not)A;Brand";v="24", "Chromium";v="116"' \
  -H 'sec-ch-ua-mobile: ?1' \
  -H 'sec-ch-ua-platform: "Android"' \
  -H 'sec-fetch-dest: document' \
  -H 'sec-fetch-mode: navigate' \
  -H 'sec-fetch-site: same-origin' \
  -H 'sec-fetch-user: ?1' \
  -H 'upgrade-insecure-requests: 1' \
  -H 'user-agent: Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Mobile Safari/537.36' \
  --data-raw "$(sed -n 3p <<< "$haha")"'&email='"$email"'&password='"$password"'' | \
  sed -nE 's/.*XSRF-TOKEN=([^;]*)\;.*/XSRF-TOKEN=\1/p;s/.*fcafessh_session=([^;]*)\;.*/fcafessh_session=\1/p' | \
  tr '\n' ';')"
hahe="$(curl -sL "https://freenet.cafe/dashboard" -H "cookie: ${hehe}" | sed -nE '/claim/ s/.*_token" value="([^"]*)".*/_token=\1/p')"
if [ -n "${hehe}" ]; then
	curl -sL "https://freenet.cafe/claim-points" -H "cookie: ${hehe}" -d "$hahe" | sed -nE 's/<span class="badge rounded-pill bg-success">([^<]*)<.*/Success!![\1]/p' | head -n 1
fi

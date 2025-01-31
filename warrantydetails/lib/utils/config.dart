enum Environment { DEV, UAT, PROD }

class Config {
  static Map<dynamic, dynamic> _config = _Config.debugConstants;

  static const double appVersion = 1.0;

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.DEV:
        _config = _Config.debugConstants;
        break;
      case Environment.UAT:
        _config = _Config.stagingConstants;
        break;
      case Environment.PROD:
        _config = _Config.prodConstants;
        break;
    }
  }

  static get loginUrl {
    return _config[_Config.loginUrl];
  }

  static get environment {
    return _config[_Config.environment];
  }

  static get baseUrl {
    return _config[_Config.baseUrl];
  }

  static get masterUrl {
    return _config[_Config.masterUrl];
  }

  static get loginToken {
    return _config[_Config.loginToken];
  }

  static get clientId {
    return _config[_Config.clientId];
  }

  static get redirectUrl {
    return _config[_Config.redirectUrl];
  }

  static get issuer {
    return _config[_Config.issuer];
  }

  static get blobsDownload {
    return _config[_Config.blobsDownloadUrl];
  }

  static get clientSecret {
    return _config[_Config.clientSecret];
  }

  static get realmsId {
    return _config[_Config.realmsId];
  }

  static get scopes {
    return _config[_Config.scopes];
  }

  static get tokenUrl {
    return _config[_Config.tokenUrl];
  }
}

class _Config {
  static const String environment = 'dev';
  static const String loginUrl = 'https://d-byufuel-auth.azurewebsites.net/';
  static const String baseUrl = 'https://warranty.shiningdawn.in/api/';
  static const String masterUrl =
      'https://d-byufuel-gateway.azure-api.net/dev/';

  static const String loginToken =
      'Ynl1ZnVlbC1zcGEtY2xpZW50LW1vYi1wd2Q6QWtmb1RNVG1VbVBDNm9XSzBOMmE4ZWFOTklVQU5NdVc=';
  static const String blobsDownloadUrl =
      "https://d-byufuel-gateway.azure-api.net/dev/blobs/download?";
  static const String clientId = 'byufuel-spa-client-mob-pwd';
  static const String redirectUrl = 'https://d-byufuel-auth.azurewebsites.net';
  static const String issuer =
      'https://d-byufuel-auth.azurewebsites.net/realms/byufuel-dev';
  static const String clientSecret = 'AkfoTMTmUmPC6oWK0N2a8eaNNIUANMuW';
  static const realmsId = 'byufuel-dev';
  static const List<String> scopes = <String>[
    'openid',
    'email',
    'byufuel-api',
    'profile',
    'offline_access'
  ];
  static const String tokenUrl =
      'realms/byufuel-dev/protocol/openid-connect/token';

  static Map<dynamic, dynamic> debugConstants = {
    loginUrl: "https://warranty.shiningdawn.in/api/",
    environment: "dev",
    baseUrl: 'https://d-byufuel-api.azurewebsites.net/',
    masterUrl: 'https://d-byufuel-gateway.azure-api.net/dev/',
    loginToken:
        'Ynl1ZnVlbC1zcGEtY2xpZW50LW1vYi1wd2Q6QWtmb1RNVG1VbVBDNm9XSzBOMmE4ZWFOTklVQU5NdVc=',
    clientId: 'byufuel-spa-client-mob-pwd',
    redirectUrl: 'https://d-byufuel-auth.azurewebsites.net',
    issuer: 'https://d-byufuel-auth.azurewebsites.net/realms/byufuel-dev',
    blobsDownloadUrl:
        "https://d-byufuel-gateway.azure-api.net/dev/blobs/download?",
    clientSecret: 'AkfoTMTmUmPC6oWK0N2a8eaNNIUANMuW',
    realmsId: 'byufuel-dev',
    tokenUrl: 'realms/byufuel-dev/protocol/openid-connect/token',
    scopes: <String>[
      'openid',
      'email',
      'byufuel-api',
      'profile',
      'offline_access'
    ]
  };

  static Map<dynamic, dynamic> stagingConstants = {
    loginUrl: "https://d-byufuel-auth.azurewebsites.net/",
    environment: "uat",
    baseUrl: 'https://u-byufuel-api.azurewebsites.net/',
    masterUrl: 'https://d-byufuel-gateway.azure-api.net/uat/',
    loginToken:
        'Ynl1ZnVlbC1zcGEtY2xpZW50LW1vYi1wd2Q6dTU0UmwxWXhDaUdHRmtPUXNDeVJuSkpueGNUNVFCZ2Q=',
    clientId: 'byufuel-spa-client-mob-pwd',
    redirectUrl: 'https://d-byufuel-auth.azurewebsites.net',
    issuer: 'https://d-byufuel-auth.azurewebsites.net/realms/byufuel-uat',
    blobsDownloadUrl:
        "https://d-byufuel-gateway.azure-api.net/dev/blobs/download?",
    clientSecret: 'u54Rl1YxCiGGFkOQsCyRnJJnxcT5QBgd',
    realmsId: 'byufuel-uat',
    tokenUrl: 'realms/byufuel-uat/protocol/openid-connect/token',
    scopes: <String>[
      'openid',
      'email',
      'byufuel-api',
      'profile',
      'offline_access'
    ]
  };

  static Map<dynamic, dynamic> prodConstants = {
    loginUrl: "https://d-byufuel-auth.azurewebsites.net/",
    environment: "prod",
    baseUrl: 'https://u-byufuel-api.azurewebsites.net/',
    masterUrl: 'https://d-byufuel-gateway.azure-api.net/uat/',
    loginToken:
        'Ynl1ZnVlbC1zcGEtY2xpZW50LW1vYi1wd2Q6dTU0UmwxWXhDaUdHRmtPUXNDeVJuSkpueGNUNVFCZ2Q=',
    clientId: 'byufuel-spa-client-mob-pwd',
    redirectUrl: 'https://d-byufuel-auth.azurewebsites.net',
    issuer: 'https://d-byufuel-auth.azurewebsites.net/realms/byufuel-uat',
    blobsDownloadUrl:
        "https://d-byufuel-gateway.azure-api.net/dev/blobs/download?",
    clientSecret: 'u54Rl1YxCiGGFkOQsCyRnJJnxcT5QBgd',
    realmsId: 'byufuel-uat',
    tokenUrl: 'realms/byufuel-uat/protocol/openid-connect/token',
    scopes: <String>[
      'openid',
      'email',
      'byufuel-api',
      'profile',
      'offline_access'
    ]
  };
}

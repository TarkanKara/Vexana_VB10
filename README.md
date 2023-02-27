# vexana_vb10

* dynamic model parsing
* base error model
* timeout 
* many utility functions

## Network Manager
* options:
    * baseurl, 
    * logger, 
    * interceptors, 
    * base model

* Hata modelinizi yönetmek istiyorsanız, modelinizi bildirmeniz yeterlidir, böylece hata modelini her yerde alabilirsiniz.

```dart
INetworkManager  networkManager = NetworkManage<Null or UserErrorModel>(isEnableLogger: true, errorModel: UserErrorModel(),
 options: BaseOptions(baseUrl: "https://jsonplaceholder.typicode.com/"));
```

## Model Parse

```dart
final response =
await networkManager.send<Todo, List<Todo>>("/todos", parseModel: Todo(), method: RequestType.GET);
```

## Base Headers

```dart
networkManager.addBaseHeader(MapEntry(HttpHeaders.authorizationHeader, response.data?.first.title ?? ''));
// Clear single header
networkManager.removeHeader('\${response.data?.first.id}');
// Clear all header
networkManager.clearHeader();
```

## Download File Simple
* pdf, png veya benzeri herhangi bir dosya formatını indirebilirsiniz.

```dart
final response = await networkManager.downloadFileSimple('http://www.africau.edu/images/default/sample.pdf', (count, total) {
      print('${count}');
});

//Example: Image.memory(response.data)
```

## Download File
* Model ve istek tipini belirterek pdf, png veya benzeri herhangi bir dosya formatını indirebilirsiniz.
```dart
final response = await networkManager.downloadFile(
    'financial-report',
    (count, total) {
      print('${count}');
    },
    method: RequestType.POST,
    data: FileDownloadModel(),
);
```

## HTTP Post Request with Request Body 
```dart
class TodoPostRequestData extends INetworkModel<TodoPostRequestData>
```

```dart
final todoPostRequestBody = TodoPostRequestData();
final response =
await networkManager.send<Todo, List<Todo>>("/todosPost", parseModel: Todo(), method: RequestType.POST, data: todoPostRequestBody);
```

## Cancel Request
```dart
final cancelToken = CancelToken();
    networkManager
        .send<ReqResModel, ReqResModel>('/users?delay=5',
            parseModel: ReqResModel(), method: RequestType.GET, canceltoken: cancelToken)
        .catchError((err) {
      if (CancelToken.isCancel(err)) {
        print('Request canceled! ' + err.message);
      }
    });

    cancelToken.cancel('canceled');

    await Future.delayed(const Duration(seconds: 8));
```

## Primitive Request
```dart
//
[
  "en",
  "tr",
  "fr"
]
//
networkManager.sendPrimitive<List>("languages");
```
## Network Model
* Modelinizi INetworkModel ile sarmalısınız, böylece modelin toJson ve fromJson yöntemleri olduğunu anlıyoruz.
```dart
class Todo extends INetworkModel<Todo>
```

## Refresh Token
* Birçok proje, mobil güvenlik için (jwt gibi) kimlik doğrulama yapısı kullanır.
* Jetonun süresi dolduğunda eski bir jetonu yenilemesi gerekebilir
* Bu kez refresh token seçeneği sağlandı, refresh token işlemi tamamlanana kadar tüm istekleri kilitleyebiliriz.
* Tüm istekleri kilitlediğim için yeni bir hizmet örneği veriyorum.
```dart
INetworkManager  networkManager = NetworkManager(isEnableLogger: true, options: BaseOptions(baseUrl: "https://jsonplaceholder.typicode.com/"),
onRefreshFail: () {  //Navigate to login },
 onRefreshToken: (error, newService) async {
    <!-- Write your refresh token business -->
    <!-- Then update error.req.headers to new token -->
    return error;
});
```

## Caching
* **[Bazen mobil cihaz önbelleğine bir response modeli yazmanız gerekir.](https://medium.com/flutter-community/cache-manager-with-flutter-5a5db0d3a3e6)**
```dart
await networkManager.send<Todo, List<Todo>>("/todos",
        parseModel: Todo(),
        expiration: Duration(seconds: 3),
        method: RequestType.GET);
```
## Without Network connection 
```dart
// First you must be initialize your context with NoNetwork class
    networkManager = NetworkManager(
      isEnableLogger: true,
      noNetwork: NoNetwork(context),
      options: BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'),

      errorModelFromData: _errorModelFromData, //This is optional.
    );

    // If you want to create custom widget, you can add in no network class with callback function.
      networkManager = NetworkManager(
      isEnableLogger: true,
      noNetwork: NoNetwork(
        context,
        customNoNetwork: (onRetry) {
          // You have to call this retry method your custom widget
          return NoNetworkSample(onPressed: onRetry);
        },
      ),
      options: BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'),

      //Example request
       final response = await networkManager.send<Post, List<Post>>('/posts',
        parseModel: Post(), method: RequestType.GET, isErrorDialog: true);
```

## Error model handle
 ```dart
INetworkManager  networkManager = NetworkManage<UserErrorModel>(isEnableLogger: true, errorModel: UserErrorModel(),
 options: BaseOptions(baseUrl: "https://jsonplaceholder.typicode.com/"));

 IResponseModel<List<Post>?, BaseErrorModel?> response =  networkManager.send<Post, List<Post>>('/posts',
        parseModel: Post(), method: RequestType.GET);
      <!-- Error.model came from your backend with your declaration -->
      showDialog(response.error?.model?.message)

    response
```
var userData = {
  "id": 1,
  "email": "c2@test.com",
  "accessToken":
      "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJjMkB0ZXN0LmNvbSIsImlzcyI6Ik1JVSIsImlhdCI6MTY5OTA0MDg2NiwiZXhwIjoxNjk5NDAwODY2LCJyb2xlIjoiVVNFUiJ9.2YzuvPUJgaoi_U3OrPOb2aBZVHfnSS_OPYMyGEWxVlW8XazhsRlGPVmsrxRqV_-FcQ0oqE344xqDsgGFySz5HA",
  "role": "USER",
  "firstName": "Customer",
  "lastName": "2",
  "profileImageUrl": "https://cdn-icons-png.flaticon.com/512/706/706830.png"
};

var userAccountData = {
  "id": 1,
  "email": "c2@test.com",
  "accessToken":
      "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJjMkB0ZXN0LmNvbSIsImlzcyI6Ik1JVSIsImlhdCI6MTY5OTA0NDAzMCwiZXhwIjoxNjk5NDA0MDMwLCJyb2xlIjoiVVNFUiJ9.VUSJonsdHH--iR4dDDQjkv4OfjTOTRYG-ToCEQJHMUGZBzJPJOKjhUeMbnv4ccn7b839azhgdS0twtAxCtiPMw",
  "role": "USER",
  "firstName": "Customer",
  "lastName": "2",
  "profileImageUrl": "https://cdn-icons-png.flaticon.com/512/706/706830.png"
};

var productsData = [
  {
    "id": 7,
    "title": "DJI Osmo Pocket 3",
    "description":
        "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content.",
    "imageUrl":
        "https://static.bhphotovideo.com/explora/sites/default/files/dji-introduces-the-improved-osmo-pocket-3-gimbal-camera-and-accessories-ts1.png",
    "categories": [
      {"id": 1, "name": "phone"}
    ],
    "released": true,
    "auction": {
      "id": 7,
      "startPrice": 600,
      "depositAmount": 60,
      "highestBid": 600,
      "bidDueDateTime": "2023-11-05T17:16:00",
      "payDate": "2023-11-06",
      "isEnd": false,
      "numberOfBidders": 0,
      "bids": [
        {
          "id": 9,
          "bidAmount": 801,
          "bidDateTime": "2023-10-25T11:35:13.736777",
          "customerId": 7,
          "customer": {
            "id": 1,
            "email": "c2@test.com",
            "role": "USER",
            "firstName": "Customer",
            "lastName": "2",
            "profileImageUrl":
                "https://cdn-icons-png.flaticon.com/512/706/706830.png"
          }
        },
        {
          "id": 10,
          "bidAmount": 802,
          "bidDateTime": "2023-10-25T11:38:38.42931",
          "customerId": 12,
          "customer": {
            "id": 1,
            "email": "c10@test.com",
            "role": "USER",
            "firstName": "Customer",
            "lastName": "10",
            "profileImageUrl":
                "https://cdn-icons-png.flaticon.com/512/180/180644.png"
          }
        },
        {
          "id": 11,
          "bidAmount": 803,
          "bidDateTime": "2023-10-25T12:16:10.325039",
          "customerId": 6,
          "customer": {
            "id": 2,
            "email": "c@test.com",
            "role": "USER",
            "firstName": "Customer",
            "lastName": "1",
            "profileImageUrl":
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQE-8SS97gyHSDVd0myt_L5yWDsAAWuh6oty8jkSabdKvPmaPSZlQuwPVay91iBmjUXAik&usqp=CAU"
          }
        },
        {
          "id": 12,
          "bidAmount": 804,
          "bidDateTime": "2023-10-25T12:25:05.747895",
          "customerId": 7,
          "customer": {
            "id": 1,
            "email": "c2@test.com",
            "role": "USER",
            "firstName": "Customer",
            "lastName": "2",
            "profileImageUrl":
                "https://cdn-icons-png.flaticon.com/512/706/706830.png"
          }
        }
      ]
    },
    "sellerId": 11
  },
  {
    "id": 5,
    "title": "iPhone 15 Pro Max",
    "description":
        "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content.",
    "imageUrl":
        "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-15-pro-finish-select-202309-6-7inch-naturaltitanium?wid=5120&hei=2880&fmt=p-jpg&qlt=80&.v=1692845702708",
    "categories": [
      {"id": 1, "name": "phone"}
    ],
    "released": true,
    "auction": {
      "id": 5,
      "startPrice": 1000,
      "depositAmount": 100,
      "highestBid": 1003,
      "bidDueDateTime": "2023-10-25T11:28:00",
      "payDate": "2023-10-26",
      "isEnd": true,
      "numberOfBidders": 2,
      "bids": [
        {
          "id": 6,
          "bidAmount": 1001,
          "bidDateTime": "2023-10-25T10:31:22.715552",
          "customerId": 12,
          "customer": {
            "id": 1,
            "email": "c10@test.com",
            "role": "USER",
            "firstName": "Customer",
            "lastName": "10",
            "profileImageUrl":
                "https://cdn-icons-png.flaticon.com/512/180/180644.png"
          }
        },
        {
          "id": 7,
          "bidAmount": 1003,
          "bidDateTime": "2023-10-25T10:31:59.464815",
          "customerId": 7,
          "customer": {
            "id": 1,
            "email": "c2@test.com",
            "role": "USER",
            "firstName": "Customer",
            "lastName": "2",
            "profileImageUrl":
                "https://cdn-icons-png.flaticon.com/512/706/706830.png"
          }
        }
      ]
    },
    "sellerId": 11
  }
];

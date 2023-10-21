 response_card = jsonencode({
    version = 1,
    content = [
      {
        "contentType": "application/vnd.amazonaws.card.generic",
        "genericAttachments": [
          {
            "title": "Food Items",
            "subTitle": "On the menu",
            "imageUrl": "vhttps://images.getbento.com/accounts/3bf33a8c2df2466870e9b332ae826067/media/images/smdp2l2o.jpeg?w=1000&fit=max&auto=compress,format&h=1000",
          
            "buttons": [
              {
                "text": "Juicy Burger",
                "value": "Burger"
              },
               {
                "text": "Hot Pizza",
                "value": "Pizza"
              }, {
                "text": "Delicious Pasta",
                "value": "Pasta"
              }, {
                "text": "Fresh Salad",
                "value": "Salad"
              }, {
                "text": "More Info",
                "value": "burger"
              }
            ]
          }
        ]
      }
    ]
  })
}

}
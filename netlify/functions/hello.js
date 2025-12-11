// منصة الفولت في الفيزياء - Netlify Function مثال
// تطوير: Abdulrahman Ghonaim

exports.handler = async (event, context) => {
  const { httpMethod, queryStringParameters, body } = event;
  
  // التحقق من طريقة الطلب
  if (httpMethod !== 'GET' && httpMethod !== 'POST') {
    return {
      statusCode: 405,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Headers': 'Content-Type',
        'Access-Control-Allow-Methods': 'GET, POST, OPTIONS'
      },
      body: JSON.stringify({ error: 'Method not allowed' })
    };
  }

  try {
    // معالجة طلب GET
    if (httpMethod === 'GET') {
      return {
        statusCode: 200,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify({
          message: 'مرحباً من منصة الفولت في الفيزياء!',
          teacher: 'مستر السيد محمد',
          developer: 'Abdulrahman Ghonaim',
          timestamp: new Date().toISOString()
        })
      };
    }

    // معالجة طلب POST
    if (httpMethod === 'POST') {
      const data = JSON.parse(body || '{}');
      
      return {
        statusCode: 200,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify({
          message: 'تم استلام البيانات بنجاح',
          receivedData: data,
          timestamp: new Date().toISOString()
        })
      };
    }

  } catch (error) {
    return {
      statusCode: 500,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({
        error: 'حدث خطأ في الخادم',
        details: error.message
      })
    };
  }
};
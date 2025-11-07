// -------------------- Fake Data Service --------------------
import '../../Models/Data/Com/Person/dto.dart';

class FakeDataService {
  static Response getFakePersons() {
    return Response(data: [
      ResponseData(personId: 1, fullName: "امیر سلیمانی", fatherName: "یاسر", nationalCode: "1234567890"),
      ResponseData(personId: 2, fullName: "فاطمه رضایی", fatherName: "علی", nationalCode: "0987654321"),
      ResponseData(personId: 3, fullName: "محمد احمدی", fatherName: "حسین", nationalCode: "1122334455"),
      ResponseData(personId: 4, fullName: "سارا کریمی", fatherName: "مهدی", nationalCode: "2233445566"),
      ResponseData(personId: 5, fullName: "علی احمدی", fatherName: "رحیم", nationalCode: "3344556677"),
      ResponseData(personId: 6, fullName: "مریم رضایی", fatherName: "امید", nationalCode: "4455667788"),
      ResponseData(personId: 7, fullName: "حسین محمدی", fatherName: "علی", nationalCode: "5566778899"),
      ResponseData(personId: 8, fullName: "لیلا صادقی", fatherName: "حسین", nationalCode: "6677889900"),
      ResponseData(personId: 9, fullName: "رضا کاظمی", fatherName: "جواد", nationalCode: "7788990011"),
      ResponseData(personId: 10, fullName: "زهرا ملکی", fatherName: "حسن", nationalCode: "8899001122"),
      ResponseData(personId: 11, fullName: "حمید رحمانی", fatherName: "سعید", nationalCode: "9900112233"),
      ResponseData(personId: 12, fullName: "نگین صفوی", fatherName: "مهدی", nationalCode: "0011223344"),
      ResponseData(personId: 13, fullName: "علی رضاپور", fatherName: "حسین", nationalCode: "1122334456"),
      ResponseData(personId: 14, fullName: "فاطمه نوروزی", fatherName: "امیر", nationalCode: "2233445567"),
      ResponseData(personId: 15, fullName: "مهدی کریمی", fatherName: "رضا", nationalCode: "3344556678"),
      ResponseData(personId: 16, fullName: "سمانه احمدی", fatherName: "جواد", nationalCode: "4455667789"),
      ResponseData(personId: 17, fullName: "رضا فراهانی", fatherName: "علی", nationalCode: "5566778890"),
      ResponseData(personId: 18, fullName: "لیلا تهرانی", fatherName: "حسین", nationalCode: "6677889901"),
      ResponseData(personId: 19, fullName: "سعید ملکی", fatherName: "مهدی", nationalCode: "7788990012"),
      ResponseData(personId: 20, fullName: "مهسا کاظمی", fatherName: "امیر", nationalCode: "8899001123"),
    ]);
  }
}

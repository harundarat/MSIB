// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract Perpustakaaan {

    struct Book {
        string title;
        uint256 year;
        string writer;
    }

    mapping(string => Book) private bookList;

    address owner;

    modifier onlyOwner {
        require(msg.sender == owner, "You're not admin");
        _;
    }

    modifier isBookNotExist(string calldata _ISBN) {
        require(bookList[_ISBN].year != 0, "Book isn't exist");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    // Fungsi untuk identitas buku
    function bookIdentity(string calldata _ISBN, string calldata _title, uint256 _year, string calldata _writer) private {
        bookList[_ISBN] = Book({
            title: _title,
            year: _year,
            writer: _writer
        });
    }

    // Menambahkan buku
    function addBook(string calldata _ISBN, string calldata _title, uint256 _year, string calldata _writer) public onlyOwner {

        require(bookList[_ISBN].year == 0, "Book already exist");

        bookIdentity(_ISBN, _title, _year, _writer);

    }

    // Mengubah buku
    function editBook(string calldata _ISBN, string calldata _title, uint256 _year, string calldata _writer) public isBookNotExist(_ISBN) onlyOwner{
        
        bookIdentity(_ISBN, _title, _year, _writer);

    }

    // Menghapus buku
    function removeBook(string calldata _ISBN) public onlyOwner isBookNotExist(_ISBN){
        delete bookList[_ISBN];

    }

    // Get Data Buku
    function getBookData(string calldata _ISBN) public view isBookNotExist(_ISBN) returns(string memory, uint256, string memory){
        Book memory _theBook = bookList[_ISBN];
        return (_theBook.title, _theBook.year, _theBook.writer);
    }

}
